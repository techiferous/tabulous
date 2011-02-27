require 'active_support/core_ext/string'

module Tabulous
  class Formatter

    # TODO: write up these rules more formally
    # note: the first #------ header sets the indentation level
    # note #2: only the insides are formatted, not the config = line
    # trailing comments at the end of table headers will be lost (fix this?)
    # trailing comments will be reinserted two spaces after end of code line
    # no comments or other code can be interspersed between rows

    def self.format(lines)
      @out = []
      inside_a_table = false
      table_lines = []
      headings = []
      indentation = nil
      lines.each do |line|
        line.rstrip!
        if inside_a_table && at_end_of_table?(line)
          prepare_formatted_table(indentation, headings, table_lines)
          inside_a_table = false
          table_lines = []
          headings = []
          indentation = nil
        end
        if inside_a_table
          stripped_line = line.strip
          at_header_labels = headings.empty? && stripped_line.starts_with?('# ') && stripped_line.slice('|')
          at_bottom_header_labels = !headings.empty? && stripped_line.starts_with?('# ') && stripped_line.slice('|')
          at_table_row = stripped_line.starts_with?('[')
          at_start_of_header = (indentation.nil? && line =~ /^(\s*)#--/)
          if at_start_of_header
            indentation = $1
          elsif at_header_labels
            headings = parse_header_labels(stripped_line)
          elsif at_table_row
            if stripped_line =~ /^\[(.+)\],(\s*|\s*#.*)$/
              cells = $1
              end_of_line_comment = $2
              table_lines << cells.split(' , ').map(&:strip) + [end_of_line_comment]
            end
          elsif stripped_line.blank?
            # blank lines go away
          elsif stripped_line.starts_with? '#--'
            # we can also safely ignore header lines as they will be regenerated
          elsif at_bottom_header_labels
            # we can also safely ignore these as they will be regenerated
          else
            raise FormattingError,
                  "Only properly formatted table rows expected. " +
                  "For example, comments can only appear at the end of table rows, not " +
                  "between them.  Aborting."
          end
        else
          @out << line
        end
        if !inside_a_table && at_beginning_of_table?(line)
          inside_a_table = true
        end
      end
      return @out
    end

    def self.parse_header_labels(line)
      headings = line.split('|')
      first_heading = headings.shift
      last_heading = headings.pop
      first_heading = first_heading.split('#').last.strip
      if last_heading =~ /#\s*\S+/
        raise FormattingError,
              "No extra text is allowed on the table heading lines.  " + 
              "Text was detected to the right of the table headers; aborting. "
      end
      last_heading = last_heading.split('#').first.strip
      headings = [first_heading] + headings.map(&:strip) + [last_heading]
      headings
    end
    private_class_method :parse_header_labels

    def self.at_beginning_of_table?(line)
      line = line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == 'config.tabs=[' || line == 'config.actions=['
    end
    private_class_method :at_beginning_of_table?
  
    def self.at_end_of_table?(line)
      line = line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == ']'
    end
    private_class_method :at_end_of_table?

    def self.prepare_formatted_table(indentation, headings, table_lines)
      num_columns = headings.size
      column_sizes = {}
      for column in (0..num_columns-1)
        cells = [headings[column]]
        cells += table_lines.map{|x| x[column]}
        column_sizes[column] = cells.map(&:length).max
      end
      padding = ' ' * 4
      column = 0
      headings = headings.map do |heading|
        result = padding + heading.ljust(column_sizes[column]) + padding
        column += 1
        result
      end
      header = headings.join('|')
      header_divider = indentation + '#' + ('-' * header.size) + '#'
      header = indentation + '#' + header + '#'
      @out << header_divider
      @out << header
      @out << header_divider
      for cells in table_lines
        for column in (0..num_columns-1)
          cells[column] = padding + cells[column].ljust(column_sizes[column]) + padding
        end
        end_of_line_comment = cells.pop
        line = cells.join(',')
        line = indentation + '[' + line + '],'
        unless end_of_line_comment.blank?
          line += '  ' + end_of_line_comment.strip
        end
        @out << line
      end
      @out << header_divider
      @out << header
      @out << header_divider
    end
    private_class_method :prepare_formatted_table

  end
end

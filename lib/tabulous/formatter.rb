require 'active_support/core_ext/string'

module Tabulous

  class Formatter
    # TODO: write up these rules more formally
    # note: the first #------ header sets the @indentation level
    # note #2: only the insides are formatted, not the config = line
    # trailing comments at the end of table headers will be lost (fix this?)
    # trailing comments will be reinserted two spaces after end of code line
    # no comments or other code can be interspersed between rows
    def self.format(lines)
      Parser.new(lines).go
    end
  end

  class Table

    attr_accessor :table_lines, :headings, :indentation

    def initialize
      @table_lines = []
      @headings = []
      @indentation = nil
    end

  end

  class Parser

    def initialize(lines)
      @input_lines = lines
      @output_lines = []
    end

    def go
      @table = nil
      @input_lines.each do |line|
        line.rstrip!
        if @table && at_end_of_table?(line)
          @output_lines += Prettifier.prettify(@table)
          @table = nil
        end
        if @table
          stripped_line = line.strip
          at_header_labels = @table.headings.empty? && stripped_line.starts_with?('# ') && stripped_line.slice('|')
          at_bottom_header_labels = !@table.headings.empty? && stripped_line.starts_with?('# ') && stripped_line.slice('|')
          at_table_row = stripped_line.starts_with?('[')
          at_start_of_header = (@table.indentation.nil? && line =~ /^(\s*)#--/)
          if at_start_of_header
            @table.indentation = $1
          elsif at_header_labels
            @table.headings = parse_header_labels(stripped_line)
          elsif at_table_row
            if stripped_line =~ /^\[(.+)\],(\s*|\s*#.*)$/
              cells = $1
              end_of_line_comment = $2
              @table.table_lines << cells.split(' , ').map(&:strip) + [end_of_line_comment]
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
          @output_lines << line
        end
        if !@table && at_beginning_of_table?(line)
          @table = Table.new
        end
      end
      return @output_lines
    end

    private

    def parse_header_labels(line)
      @table.headings = line.split('|')
      first_heading = @table.headings.shift
      last_heading = @table.headings.pop
      first_heading = first_heading.split('#').last.strip
      if last_heading =~ /#\s*\S+/
        raise FormattingError,
              "No extra text is allowed on the table heading lines.  " + 
              "Text was detected to the right of the table headers; aborting. "
      end
      last_heading = last_heading.split('#').first.strip
      @table.headings = [first_heading] + @table.headings.map(&:strip) + [last_heading]
      @table.headings
    end

    def at_beginning_of_table?(line)
      line = line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == 'config.tabs=[' || line == 'config.actions=['
    end
  
    def at_end_of_table?(line)
      line = line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == ']'
    end

  end

  class Prettifier
    def self.prettify(table)
      indentation = table.indentation
      headings = table.headings
      table_lines = table.table_lines
      @output_lines = []
      num_columns = headings.size
      column_sizes = {}
      for column in (0..num_columns-1)
        cells = [headings[column]]
        cells += table_lines.map{|x| x[column]}
        empty_cell = cells.find_index(&:nil?)
        if empty_cell
          raise FormattingError,
                "There appears to be at least one missing table cell, probably " +
                "in row #{empty_cell}."
        end
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
      @output_lines << header_divider
      @output_lines << header
      @output_lines << header_divider
      for cells in table_lines
        if (cells.size-1) != num_columns  # subtract one because the last column are the comments
          if cells.size > 0
            raise FormattingError,
                  "Wrong number of table cells in row #{cells.first}.  " +
                  "Expected #{num_columns} cells, got #{cells.size-1}."
          else
            raise FormattingError,
                  "One of the tables has the wrong number of cells."
          end
        end
        for column in (0..num_columns-1)
          cells[column] = padding + cells[column].ljust(column_sizes[column]) + padding
        end
        end_of_line_comment = cells.pop
        line = cells.join(',')
        line = indentation + '[' + line + '],'
        unless end_of_line_comment.blank?
          line += '  ' + end_of_line_comment.strip
        end
        @output_lines << line
      end
      @output_lines << header_divider
      @output_lines << header
      @output_lines << header_divider
      @output_lines
    end
  end

end

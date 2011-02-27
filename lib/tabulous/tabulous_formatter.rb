require 'active_support/core_ext/string'

class TabulousFormatter

  def self.format(lines)
    @out = []
    inside = false
    inside_lines = []
    headings = []
    indentation = nil
    lines.each do |line|
      line = line.rstrip
      if inside && end_line?(line)
        output_formatted_table(indentation, headings, inside_lines)
        inside = false
        inside_lines = []
        headings = []
        indentation = nil
      end

      if inside
        stripped_line = line.strip
        if indentation.nil? && line =~ /^(\s*)#--/
          # note: the first #------ header sets the indentation level
          # note #2: only the insides are formatted, not the config = line
          indentation = $1
        elsif headings.empty? && stripped_line.starts_with?('# ') && stripped_line.slice('|')
          headings = stripped_line.split(%r{(#|\|)}).map(&:strip)
          headings.reject!{|x| x.empty? || x == '#' || x == '|'}
        elsif stripped_line.starts_with?('[')
          if stripped_line =~ /^\[(.+)\],(\s*|\s*#.*)$/
            cells = $1
            end_of_line_comment = $2
            inside_lines << cells.split(' , ').map(&:strip) + [end_of_line_comment]
          end
        end
      else
        output line
      end

      if !inside && start_line?(line)
        inside = true
      end
    end
    return @out
  end

  def self.output(line)
    @out << line
  end
  
  def self.start_line?(line)
    line = line.split('#').first # naively strip out comments
    return false if line.nil?
    line = line.gsub(/\s/, '')
    return line == 'config.tabs=[' || line == 'config.actions=['
  end
  
  def self.end_line?(line)
    line = line.split('#').first # naively strip out comments
    return false if line.nil?
    line = line.gsub(/\s/, '')
    return line == ']'
  end
  
  def self.output_formatted_table(indentation, headings, inside_lines)

    num_columns = headings.size
    column_sizes = {}
    for column in (0..num_columns-1)
      cells = [headings[column]]
      cells += inside_lines.map{|x| x[column]}
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
    output header_divider
    output header
    output header_divider
    
    for cells in inside_lines
      for column in (0..num_columns-1)
        cells[column] = padding + cells[column].ljust(column_sizes[column]) + padding
      end
      end_of_line_comment = cells.pop
      line = cells.join(',')
      line = indentation + '[' + line + '],'
      unless end_of_line_comment.blank?
        line += '  ' + end_of_line_comment.strip
      end
      output line
    end

    output header_divider
    output header
    output header_divider
  end

end

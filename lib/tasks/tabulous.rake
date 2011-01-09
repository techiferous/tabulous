namespace :co do
  desc "Prettify captain obvious files"
  task :format do
    
    $out = []
    
    def output(line)
      $out << line
    end
    
    def start_line?(line)
      line = line.split('#').first # naively strip out comments
      return line =~ /\[\s*$/
    end
    
    def end_line?(line)
      line = line.split('#').first # naively strip out comments
      return line =~ /^\s*\]\s*$/
    end
    
    # indention should be called indentation
    def output_formatted_table(indention, headings, inside_lines)
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
      header_divider = indention + '#' + ('-' * header.size) + '#'
      header = indention + '#' + header + '#'
      output header_divider
      output header
      output header_divider
      
      for cells in inside_lines
        for column in (0..num_columns-1)
          cells[column] = padding + cells[column].ljust(column_sizes[column]) + padding
        end
        end_of_line_comment = cells.pop
        line = cells.join(',')
        line = indention + '[' + line + '],'
        unless end_of_line_comment.blank?
          line += '  ' + end_of_line_comment.strip
        end
        output line
      end

      output header_divider
      output header
      output header_divider
    end

    captain_obvious_files = File.join(Rails.root.to_s, '**', '*.co.rb')
    Dir[captain_obvious_files].each do |filename|
      inside = false
      inside_lines = []
      headings = []
      indention = nil
      File.open(filename, 'r').each do |line|
        if inside && end_line?(line)
          output_formatted_table(indention, headings, inside_lines)
          inside = false
          inside_lines = []
          headings = []
          indention = nil
        end
        

        if inside
          stripped_line = line.strip
          if indention.nil? && line =~ /^(\s*)#--/
            indention = $1
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

      File.open(filename, 'w') do |f|
        f.puts $out
      end

    end

  end
end

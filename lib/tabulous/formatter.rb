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

    attr_reader :header_cells, :end_of_row_comments, :rows
    attr_accessor :indentation

    def initialize
      @rows = []
      @header_cells = []
      @end_of_row_comments = []
      @indentation = nil
    end

    def header_cells=(val)
      @header_cells = val
      calculate_column_widths
    end

    def add_row(cells, end_of_row_comment)
      @rows << cells
      @end_of_row_comments << end_of_row_comment
      calculate_column_widths
    end

    def column_width(column_number)
      @column_widths[column_number]
    end

    private

    def calculate_column_widths
      @column_widths = {}
      num_columns = @header_cells.size
      for column in (0..num_columns-1)
        column_cells = [@header_cells[column]]
        row_number = 0
        column_cells += @rows.map do |row|
          row_number += 1
          if row[column].nil?
            raise FormattingError,
                  "There appears to be at least one missing table cell, probably " +
                  "in row ##{row_number}, column ##{column}."
          else
            row[column]
          end
        end
        @column_widths[column] = column_cells.map(&:length).max
      end
    end

  end

  class Line

    def initialize(line)
      @line = line
    end

    def text
      @line
    end

    def beginning_of_table?
      line = @line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == 'config.tabs=[' || line == 'config.actions=['
    end
  
    def end_of_table?
      line = @line.split('#').first # naively strip out comments
      return false if line.nil?
      line = line.gsub(/\s/, '')
      return line == ']'
    end

    def horizontal_rule?
      @line =~ /^(\s*)#--/
    end

    def header_cells?
      stripped_line = @line.strip
      stripped_line.starts_with?('# ') && stripped_line.slice('|')
    end

    def table_cells?
      stripped_line = @line.strip
      stripped_line.starts_with?('[')
    end

    def blank?
      @line.strip.blank?
    end

    def indentation
      @line =~ /^(\s*)\S+/
      $1.size
    end

    def header_cells
      return nil unless header_cells?
      cells = @line.strip.split('|')
      first_cell = cells.shift
      first_cell = first_cell.split('#').last.strip
      last_cell = cells.pop
      if last_cell =~ /#\s*\S+/
        raise FormattingError,
              "No extra text is allowed on the table header lines.  " + 
              "Text was detected to the right of the table headers; aborting. "
      end
      last_cell = last_cell.split('#').first.strip
      [first_cell] + cells.map(&:strip) + [last_cell]
    end

    def table_cells
      if @line.strip =~ /^\[(.+)\],(\s*|\s*#.*)$/
        cells = $1
        end_of_row_comment = $2
        cells = cells.split(' , ').map(&:strip)
        [cells, end_of_row_comment]
      else
        raise FormattingError,
              "Only properly formatted table rows expected. " +
              "For example, comments can only appear at the end of table rows, not " +
              "between them.  Aborting."
      end
    end

  end

  class Parser

    def initialize(lines)
      @input_lines = lines
      @output_lines = []
    end

    def go
      @current_table = nil
      @input_lines.each do |input_line|
        line = Line.new(input_line)
        if @current_table && line.end_of_table?
          @output_lines += Prettifier.prettify(@current_table)
          @current_table = nil
        end
        if @current_table
          at_start_of_header = (@current_table.indentation.nil? && line.horizontal_rule?)
          at_top_header_cells = @current_table.header_cells.empty? && line.header_cells?
          at_bottom_header_cells = !@current_table.header_cells.empty? && line.header_cells?
          if at_start_of_header
            @current_table.indentation = line.indentation
          elsif at_top_header_cells
            @current_table.header_cells = line.header_cells
          elsif line.table_cells?
            @current_table.add_row(*line.table_cells)
          elsif line.blank?
            # blank lines go away
          elsif line.horizontal_rule?
            # we can also safely ignore header lines as they will be regenerated
          elsif at_bottom_header_cells
            # we can also safely ignore these as they will be regenerated
          else
            raise FormattingError,
                  "Only properly formatted table rows expected. " +
                  "For example, comments can only appear at the end of table rows, not " +
                  "between them.  Aborting."
          end
        else
          @output_lines << line.text
        end
        if !@current_table && line.beginning_of_table?
          @current_table = Table.new
        end
      end
      return @output_lines
    end

  end

  class Prettifier
    def self.prettify(table)
      indentation = table.indentation
      headings = table.header_cells
      @output_lines = []
      num_columns = headings.size
      column = 0
      headings = headings.map do |heading|
        result = build_cell(heading, table.column_width(column))
        column += 1
        result
      end
      header = headings.join('|')
      header_divider = (' '*indentation) + '#' + ('-' * header.size) + '#'
      header = (' '*indentation) + '#' + header + '#'
      @output_lines << header_divider
      @output_lines << header
      @output_lines << header_divider
      table.rows.each_with_index do |cells, index|
        end_of_row_comment = table.end_of_row_comments[index]
        if cells.size != num_columns
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
          cells[column] = build_cell(cells[column], table.column_width(column))
        end
        line = cells.join(',')
        line = (' '*indentation) + '[' + line + '],'
        unless end_of_row_comment.blank?
          line += '  ' + end_of_row_comment.strip
        end
        @output_lines << line
      end
      @output_lines << header_divider
      @output_lines << header
      @output_lines << header_divider
      @output_lines
    end

    def self.build_cell(text, width)
      padding = ' ' * 4
      padding + text.ljust(width) + padding
    end
  end

end

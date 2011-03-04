require 'active_support/core_ext/string'

module Tabulous



  class Formatter
    def self.format(lines)
      Parser.new(lines).go
    end
  end



  class Parser

    def initialize(lines)
      @input_lines = lines
    end

    def go
      output_lines = []
      @current_table = nil
      @input_lines.each do |input_line|
        line = Line.new(input_line)
        if @current_table && line.end_of_table?
          output_lines += Prettifier.new(@current_table).prettify
          @current_table = nil
        end
        if @current_table
          at_start_of_header = (@current_table.indentation.nil? && line.horizontal_rule?)
          at_top_header_row = @current_table.header_row.empty? && line.header_row?
          at_bottom_header_row = !@current_table.header_row.empty? && line.header_row?
          if at_start_of_header
            @current_table.indentation = line.indentation
          elsif at_top_header_row
            @current_table.header_row = line.header_row
          elsif line.table_row?
            @current_table.add_row(*line.table_row)
          elsif line.blank?
            # blank lines go away
          elsif line.horizontal_rule?
            # we can also safely ignore header lines as they will be regenerated
          elsif at_bottom_header_row
            # we can also safely ignore this as it will be regenerated
          else
            raise FormattingError,
                  "Only properly formatted table rows expected. " +
                  "For example, comments can only appear at the end of table rows, not " +
                  "between them.  Aborting."
          end
        else
          output_lines << line.text
        end
        if !@current_table && line.beginning_of_table?
          @current_table = Table.new
        end
      end
      return output_lines
    end

  end



  class Table

    attr_reader :header_row, :end_of_row_comments, :rows
    attr_accessor :indentation

    def initialize
      @rows = []
      @header_row = []
      @end_of_row_comments = []
      @indentation = nil
    end

    def header_row=(val)
      @header_row = val
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

    def number_of_columns
      @header_row.size
    end

    private

    def calculate_column_widths
      @column_widths = {}
      for column in (0..number_of_columns-1)
        column_cells = [@header_row[column]]
        row_number = 0
        column_cells += @rows.map do |row|
          row_number += 1
          if row[column].nil?
            raise FormattingError,
                  "There appears to be at least one missing table cell, probably " +
                  "in row ##{row_number}, column ##{column+1}.  Remember that commas " +
                  "that separate table cells must be surrounded by spaces or " +
                  "the formatter gets confused."
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
      line.strip == '['
    end
  
    def end_of_table?
      line = @line.split('#').first # naively strip out comments
      return false if line.nil?
      line.strip == ']'
    end

    def horizontal_rule?
      @line =~ /^(\s*)#--/
    end

    def header_row?
      stripped_line = @line.strip
      stripped_line.starts_with?('# ') && stripped_line.slice('|')
    end

    def table_row?
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

    def header_row
      return nil unless header_row?
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

    def table_row
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



  class Prettifier

    def initialize(table)
      @table = table
    end

    def prettify
      output_lines = []
      output_lines += build_header_row
      @table.rows.each_with_index do |cells, index|
        if cells.size != @table.number_of_columns
          if cells.size > 0
            raise FormattingError,
                  "Wrong number of table cells in row #{cells.first}.  " +
                  "Expected #{@table.number_of_columns} cells, got #{cells.size}.  " +
                  "Remember that if you put Ruby expressions inside of table cells, the " +
                  "expressions should not have commas surrounded by spaces or the " +
                  "formatter gets confused."
          else
            raise FormattingError,
                  "One of the tables has the wrong number of cells."
          end
        end
        if cells.map(&:strip).any?(&:blank?)
            raise FormattingError,
                  "You have at least one empty cell in row ##{index+1}."
        end
        for column in (0..@table.number_of_columns-1)
          cells[column] = build_cell(cells[column], @table.column_width(column))
        end
        line = cells.join(',')
        line = indent('[' + line + '],')
        end_of_row_comment = @table.end_of_row_comments[index]
        unless end_of_row_comment.blank?
          line += '  ' + end_of_row_comment.strip
        end
        output_lines << line
      end
      output_lines += build_header_row
      output_lines
    end

    private

    def build_cell(text, width)
      padding = ' ' * 4
      padding + text.ljust(width) + padding
    end

    def indent(s)
      ' ' * @table.indentation + s
    end

    def build_header_row
      output_lines = []
      column = 0
      headings = @table.header_row.map do |heading|
        result = build_cell(heading, @table.column_width(column))
        column += 1
        result
      end
      header = headings.join('|')
      header_divider = indent('#' + ('-' * header.size) + '#')
      header = indent('#' + header + '#')
      output_lines << header_divider
      output_lines << header
      output_lines << header_divider
      output_lines
    end

  end



end

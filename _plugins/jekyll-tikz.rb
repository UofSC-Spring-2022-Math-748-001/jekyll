module Jekyll
  module Tags
    class Tikz < Liquid::Block
      def initialize(tag_name, markup, tokens)
        super
        @file_name = markup.gsub(/\s+/, "")

        @header = <<-'END'
        \documentclass{standalone}
        \usepackage{tikz}
        \usetikzlibrary{arrows}
        \usepackage{amsmath}
        \usepackage{amsfonts}
        \begin{document}
        \begin{tikzpicture}
        END

        @footer = <<-'END'
        \end{tikzpicture}
        \end{document}
        END
      end

      def render(context)
        tikz_code = @header + super + @footer

        tmp_directory = File.join(Dir.pwd, "_tikz_tmp", File.basename(context["page"]["url"], ".*"))
        tex_path = File.join(tmp_directory, "#{@file_name}.tex")
        pdf_path = File.join(tmp_directory, "#{@file_name}.pdf")
        FileUtils.mkdir_p tmp_directory

        dest_directory = File.join(Dir.pwd, "assets/images/svg", File.basename(context["page"]["url"], ".*"))
        dest_path = File.join(dest_directory, "#{@file_name}.svg")
        FileUtils.mkdir_p dest_directory

        pdf2svg_path = context["site"]["pdf2svg"]

        # if the file doesn't exist or the tikz code is not the same with the file, then compile the file
        if !File.exist?(tex_path) or !tikz_same?(tex_path, tikz_code) or !File.exist?(dest_path)
          File.open(tex_path, 'w') { |file| file.write("#{tikz_code}") }
          system("pdflatex -output-directory #{tmp_directory} #{tex_path}")
          system("#{pdf2svg_path} #{pdf_path} #{dest_path}")
        end

        web_dest_path = File.join("/assets/images/svg", File.basename(context["page"]["url"], ".*"), "#{@file_name}.svg")
        "<embed src=\"#{web_dest_path}\" type=\"image/svg+xml\" />"
      end

      private

      def tikz_same?(file, code)
        File.open(file, 'r') do |file|
          file.read == code
        end
      end

    end
  end
end

Liquid::Template.register_tag('tikz', Jekyll::Tags::Tikz)
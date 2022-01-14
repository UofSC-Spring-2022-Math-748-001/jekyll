module Jekyll
  module Tags
    class RenderProof < Liquid::Block

      def render(context)
        site = context.registers[:site]
        page = context.registers[:page]
        converter = site.find_converter_instance(::Jekyll::Converters::Markdown)
        body = converter.convert(super(context))
        if page["proofOpen"]
          flag = "open"
        else 
          flag = ""
        end 

        output = <<~EOS
          
          <details #{flag}>
          <summary>
          <b>Proof</b>. (Expand to view)
          </summary> 
          <p>#{body}</p> 
          <span style="float:right;"> &#9632; </span>&nbsp;
          </details>
        EOS

        return output
      end
    end
  end
end

Liquid::Template.register_tag('proof', Jekyll::Tags::RenderProof)
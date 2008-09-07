require 'hpricot'

module HpricotTextGSub
  module NodeWithChildrenExtension
    def text_gsub!(*args, &block)
      children.each { |x| x.text_gsub!(*args, &block) }
    end
  end
  
  module TextNodeExtension
    def text_gsub!(*args, &block)
      content.gsub!(*args, &block)
    end
  end
end

module Hpricot
  
  class Doc
    def highlight(config)
      syntax = Hpricot.parse(config)

      (self/:pre).each do |pre|
        
        language_class = pre.attributes['class']        
        language       = (syntax/language_class.to_sym).first if language_class
        
        if language
        
          (language/:item).each do |item|
            match_class = (item/:class).first.innerHTML
          
            (item/:expected).each do |expected|
              (pre/:code).each do |code|
                code.text_gsub!(Regexp.new(expected.innerHTML)) {|match| "<span class='#{match_class}'>#{match}</span>"}
              end
            end
          
          end
        end
      end
      self
    end
  end
    
end

module RubyInfusion
  module CodeHighlighter

    def highlight_code(text="")
      doc    = Hpricot(text) {|f| hpricot f, :xhtml_strict => true}
      config = File.open("#{File.dirname(__FILE__)}/../config/config.xml")
      doc.highlight(config).to_s
    end

    def highlight_textile_code(text="")
      highlight_code(textilize(text))
    end

  end
end
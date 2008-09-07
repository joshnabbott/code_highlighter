require 'code_highlighter'

ActionView::Base.send(:include, RubyInfusion::CodeHighlighter)
Hpricot::Doc.send(:include,  HpricotTextGSub::NodeWithChildrenExtension)
Hpricot::Elem.send(:include, HpricotTextGSub::NodeWithChildrenExtension)
Hpricot::Text.send(:include, HpricotTextGSub::TextNodeExtension)

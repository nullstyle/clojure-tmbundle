module Clojure  

  class Parser
    OPEN_TOKENS =   %w| #{ { #( '( ( [ |
    CLOSE_TOKENS =  %w| ) } ]|
    
    SCAN_TOKENS = (OPEN_TOKENS + CLOSE_TOKENS).map do |t|
      Regexp.escape(t)
    end
    
    SCANNER = Regexp.new(SCAN_TOKENS.join("|"))

    
    # Returns a hash of top-level forms, indexed by the range they occupy in the text
    def self.parse(text)
      
      expressions = {}
      current_start = 0
      depth = 0
      

      text.scan(SCANNER) do |m|
      
        offset = $~.offset(0).first
        case
        when OPEN_TOKENS.include?(m)
          current_start = offset if depth == 0
          depth += 1
        when CLOSE_TOKENS.include?(m)
          depth -= 1
          raise "explode: #{offset}" if depth < 0
          expressions[current_start..offset] = text[current_start..offset] if depth == 0
        end
        
      end

      expressions
      
    end
    
  end
end


if $0 == __FILE__
  p Clojure::Parser.parse("#(foo) {:foo :bar}")
end
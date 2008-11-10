module Clojure  
  class << self
    def ensure_running(project_name)
      Clojure.get_repl(project_name) || Clojure.run(project_name)
    end
    
    def run(project_name)
      REPL.new(project_name).run
    end
    
    def running_clojuremates
      Dir["#{Dir::tmpdir}/*"].map do |line|
        if line =~ /ClojureMate-(.+)\.port/
          name = $1
          REPL.new(name)
        end
      end.compact
    end
    
    def get_repl(project_name)
      running_clojuremates.find{|repl| repl.name == project_name}
    end
    
  end
end

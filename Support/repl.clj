(import '(java.net ServerSocket Socket SocketException)
        '(java.io InputStreamReader OutputStreamWriter File)
        '(clojure.lang LineNumberingPushbackReader))
        
(use 'clojure.contrib.duck-streams)
 
(defn on-thread [f]
  (doto (new Thread f) (start)))
 
(defn create-server 
  "creates and returns a server socket on port, will pass the client
  socket to accept-socket on connection" 
  [accept-socket port]
    (let [ss (new ServerSocket port)]
      (on-thread #(when-not (. ss (isClosed))
                    (try (accept-socket (. ss (accept)))
                         (catch SocketException e))
                    (recur)))
      ss))
 
(defn repl
  "runs a repl on ins and outs until eof"
  [ins outs]
    (binding [*ns* (create-ns 'user)
              *warn-on-reflection* false
              *out* (new OutputStreamWriter outs)]
      (let [eof (new Object)
            r (new LineNumberingPushbackReader (new InputStreamReader ins))]
        (loop [e (read r false eof)]
          (when-not (or (= e :repl_eof) (= e eof))
            (prn (eval e))
            (flush)
            (recur (read r false eof)))))))
 
(defn socket-repl 
  "starts a repl thread on the iostreams of supplied socket"
  [s] (on-thread #(do(repl (. s (getInputStream)) (. s (getOutputStream))) (.close s))))
 

(def server (create-server socket-repl 0))
(def port (.getLocalPort server))
(def port-file-path (.getenv System "REPL_PORT_FILE"))
(def port-file (File. port-file-path))
(.. Runtime getRuntime (addShutdownHook (Thread. #(.delete port-file))))
(spit port-file-path port)

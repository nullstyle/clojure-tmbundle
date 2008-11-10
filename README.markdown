The Clojure Textmate Bundle.
Version 0.1 (released November 9, 2008)

<h2>Prerequisites</h2>

The Clojure bundle depends on the following external utilities to work:

<pre>
  ruby
  screen
  osascript
</pre>

If either of those aren't on your Textmate's PATH, these commands will fail in unknown and spectacular fashion.

<h2>Installation</h2>

* Run this:
 
<pre>
cd ~/Library/Application\ Support/TextMate/Bundles
git clone git://github.com/nullstyle/clojure-tmbundle.git Clojure.tmbundle
</pre>

<h2>Using the bundle</h2>
<strong>Note: the Clojure bundle currently only works with textmate projects...  one-off files will fail.</srong>
  
This bundle spawns a Clojure REPL (unique to each TextMate project) in the background (using screen), which then receives commands from textmate, and returns the evaluated forms.

Apple-R will run the top-level expression which the caret is currently on.  If a selection is set, every top-level expression that intersects with the selection will be passed to the repl

Apple-Shift-R will run the entire file in the REPL

Apple-Option-R will open a terminal and connect to the screen instance running the current project's REPL

<h2>Bundled Clojure</h2>

To less the setup curve, I bundle the following items to provide a self-contained and featureful Clojure environment:

<pre>
clojure.jar (v1086)
clojure-contrib.jar (v233)
jline (for readline support)
jna
clj  (ruby script to help launch Clojure)
</pre>

In a future revision,  I plan to allow customization/updates to this environment. 

<h2>Support</h2>

* <a href="mailto:nullstyle@gmail.com">Drop me an emailt</a>.

* Repositories: 
  
  * <a href="http://github.com/nullstyle/clojure-tmbundle/">On GitHub</a>.

<hr />

<h3>Major Contributions</h3>

* <b>Scott Fleckenstein</b> - Started it.

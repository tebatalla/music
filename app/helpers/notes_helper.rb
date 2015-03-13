module NotesHelper
  def ugly_lyrics(lyrics)
    lines = h(lyrics).split("\n")
    lines.map! do |line|
      "&#9835; " + line
    end
    "<pre>#{lines.join("\n")}</pre>".html_safe
  end
end

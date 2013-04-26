Rebol [
    see:  https://gist.github.com/miyagawa/5455942
    comment: "My early stab at it... need to fix {text}"
    github-support: "Why does Rebol syntax highlighting no work in gist? (fine rest of Github)??"
]

split-string: func [text delim /local s coll] [
    coll: copy []
    parse/all text [
        some [copy s [to delim | to end] (append coll s) delim]
    ]
    coll
]

pick-random: func [from-series] [
    random/seed now  ; only needs to be done once per script but here so not forgotten!
    pick from-series random length? from-series
]

spam-text: read https://gist.github.com/shanselman/5422230/raw/9863d88bde2f9dcf6b2e7a284dd4a428afdc8
samples:   split-string spam-text "|^/"
template:  pick-random samples

; below replaces {placeholders} within the input stream (template)
parse/all template [
    any [
        thru "{" begin: copy s to "}" ending:
        ;(move-mark: change/part begin "XXXX" ending) :move-mark
        (
            text: split-string s "|"
            move-mark: change/part begin pick-random text ending
        )
        :move-mark  ; moved the mark to end of change
    ]
]

print template


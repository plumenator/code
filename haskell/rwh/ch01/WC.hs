main = interact wordCount_w
    where wordCount_l input = show (length (lines input)) ++ "\n"
          wordCount_w input = show (length (words input)) ++ "\n"
          wordCount_c input = show (length input) ++ "\n"
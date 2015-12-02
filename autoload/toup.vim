" vim-toup
" Auto capitalize ("to up" or "to uppercase") the first letter while typing
" Inspired by: https://davidxmoody.com/vim-auto-capitalisation/

let s:pattern_cache = {}
let toup#patterns = {}

" Beginning of file
let toup#patterns['bof'] = '%^'

" Matches either of these punctuation signs. Followed be one or more
" whitespace which may or may not include newlines
let toup#patterns['after_punctuation'] = '[.!?]\_s+'

" Lists: Matches a dash, a star or a plus sign at the start of a line
" including whitespace or not followed by a whitespace character
let toup#patterns['lists'] = '\_^\s*[-\*+]+\s'

" Matches a paragraph
let toup#patterns['paragraphs'] = '\n\n'

" Matches markdown heading, 1 to 6 levels
let toup#patterns['markdown_headings'] = '\_^#{1,6}\s+'

func! s:create_pattern(patterns)
  let pattern = ['\v'] " Start very magic pattern matching mode
  let pattern += ['('] " Begin of atom
  let pattern += [join(a:patterns, '|')] " Make them OR matches
  let pattern += [')'] " End of atom
  let pattern += ['%#'] " Matches at the cursor

  return join(pattern, '')
endfunc

func! toup#up(type, patterns)
  if has_key(s:pattern_cache, a:type) == 0
    let s:pattern_cache[a:type] = s:create_pattern(a:patterns)
  endif
  if search(s:pattern_cache[a:type], 'bcnW') != 0
    let v:char = toupper(v:char)
  endif
endfunc

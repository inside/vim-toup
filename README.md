# vim-toup

## Auto capitalize ("to up" or "to uppercase") the first letter while typing

Inspired by:
[vim-auto-capitalisation](https://davidxmoody.com/vim-auto-capitalisation/)

## ~/.vimrc example

    " User patterns to auto capitalize the first letter of a word while typing
    let s:toup = {}
    let s:toup['text'] = []
    let s:toup['text'] += [toup#patterns['bof']]
    let s:toup['text'] += [toup#patterns['after_punctuation']]
    let s:toup['text'] += [toup#patterns['lists']]

    " Matches '[foo] ' at the start of the line. Useful for my git commit messages
    let s:toup['git'] = ['^\[[^\]]*\]\s+']
    let s:toup['git'] += s:toup['text']

    augroup toup
      autocmd!
      autocmd InsertCharPre COMMIT_EDITMSG call toup#up('git', s:toup['git'])
      autocmd InsertCharPre *.md,*.txt call toup#up('text', s:toup['text'])
    augroup END

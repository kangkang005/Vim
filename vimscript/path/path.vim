:echo expand('%')                           " test.vim，相对路径
:echo expand('%:p')                         " ~/vimDir/test.vim，绝对路径
:echo expand('%:p:h')                       " ~/vimDir，移除最后一个路径
:echo expand('%:p:t')                       " test.vim，最后部分路径
:echo expand('%:p:r')                       " ~/vimDir/test，移除扩展名
:echo expand('%:p:e')                       " vim，只保留扩展名
:echo expand('%:p:t:r')                     " test
:echo fnamemodify('foo.txt', ':p')          " ~/vimDir/foo.txt，构建指定文件路径

:echo globpath('.', '*')                    " 列举当前文件夹所有文件，不递归子文件夹
:echo globpath('.', '**')                   " 列举当前文件夹及其子文件夹的所有文件
:echo split(globpath('.', '*.md'), '\n')    " 列举当前文件夹所有 .md 文件，返回列表
:echo split(globpath('.', '**/*.md'), '\n') " 列举当前文件夹及其子文件夹的所有 .md 文件，返回列表
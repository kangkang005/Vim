Reading
    Event                   When

    BufNewFile	            编辑尚不存在的新文件时
    BufReadPre	            读取文件前，开始编辑缓冲区（buffer) 时
    BufRead	                读取文件后，开始编辑缓冲区时
    BufReadPost	            读取文件后，开始编辑缓冲区时
    BufReadCmd	            开始编辑新缓冲区前 Cmd-event
    FileReadPre	            执行:read 命令读取文件前
    FileReadPost	        执行:read 命令读取文件后
    FileReadCmd	            执行:read 命令读取文件前 Cmd-event
    FilterReadPre	        过滤读取文件前
    FilterReadPost	        过滤读取文件后
    StdinReadPre	        在从标准输入中读取文件到缓冲区前
    StdinReadPost	        在从标准输入中读取文件到缓冲区后

Writing
    Event                   When

    BufWritePre	            把缓冲区全部内容写入到文件前
    BufWrite	            把缓冲区全部内容写入到文件
    BufWritePost	        把缓冲区全部内容写入到文件后
    BufWriteCmd	            把缓冲区全部内容写入到文件前 Cmd-event
    FileWritePre	        开始把缓冲区部分内容写入到文件前
    FileWritePost	        开始把部分缓冲区内容写入到文件后
    FileWriteCmd	        开始把缓冲区部分内容写入到文件前 Cmd-event
    FileAppendPre	        开始追加内容到文件前
    FileAppendPost	        开始追加内容到文件后
    FileAppendCmd	        开始追加内容到文件前 Cmd-event
    FilterWritePre	        过滤文件 或 diff 开始写入文件前
    FilterWritePost	        过滤文件 或 diff 开始写入文件后

Buffers
    Event                   When

    BufAdd	                将缓冲区添加到缓冲区列表后
    BufCreate	            将缓冲区添加到缓冲区列表后 (?)
    BufDelete	            将缓冲区从缓冲区列表删除前
    BufWipeout	            完全删除缓冲区前
    BufFilePre	            改变当前缓冲区名称前
    BufFilePost	            改变当前缓冲区名称后
    BufEnter	            进入缓冲区后
    BufLeave	            进入其他缓冲区前（即离开当前缓冲区时）
    BufWinEnter	            窗口显示缓冲区内容前
    BufWinLeave	            窗口删除缓冲区内容前
    BufUnload	            移除缓冲区前
    BufHidden	            刚隐藏缓冲区后
    BufNew	                新创建缓冲区后
    SwapExists	            检测到交换文件已存在时
    TermOpen	            开启终端任务时
    TermEnter	            进入终端模式时
    TermLeave	            退出终端模式时
    TermClose	            停止终端任务时
    ChanOpen	            通道开启后
    ChanInfo	            通道状态改变后

Options
    Event                   When

    FileType	            设置了 filetype 选项时
    Syntax	                设置了 syntax 选项时
    OptionSet	            当设置了任何选项后

Startup and exit
    Event                   When

    VimEnter	            完成所有初始化操作后（即进入 Vim 时）
    UIEnter	                进入 UI 后
    UILeave	                退出 UI 后
    TermResponse	        在接收到终端回复 t_RV 后
    QuitPre	                当使用:quit，在决定退出前
    ExitPre	                当使用可能使 Vim 退出的命令前
    VimLeavePre	            在退出 Vim 前，在写入到 shada 文件前
    VimLeave	            在退出 Vim 前，在写入到 shada 文件后
    VimResume	            在 Neovim 恢复后
    VimSuspend	            在 Neovim 暂停前

Various
    Event                   When

    DiffUpdated	            刷新比较结果后
    DirChanged	            当前工作目录改变后
    FileChangedShell	    在编辑文件后，Vim 检测到文件已被改变
    FileChangedShellPost    在对编辑文件更改处理完成后
    FileChangedRO	        对只读文件第一次修改前
    ShellCmdPost	        在执行 shell 命令后
    ShellFilterPost	        shell 命令执行完过滤后
    CmdUndefined	        调用未定义的用户命令
    FuncUndefined	        调用未定义的用户函数
    SpellFileMissing	    无法找到拼写文件
    SourcePre	            加载 Vim 脚本之前
    SourcePost	            加载 Vim 脚本之后
    SourceCmd	            加载 Vim 脚本之前 Cmd-event
    VimResized	            Vim 窗口大小改变后
    FocusGained	            Vim 获取到焦点
    FocusLost	            Vim 失去焦点
    CursorHold	            光标静止，即用户一段时间内未按键
    CursorHoldI	            用户在插入模式下一段时间内未按键
    CursorMoved	            光标在正常模式下移动
    CursorMovedI	        光标在插入模式下移动
    WinNew	                创建新窗口后
    WinEnter	            进入另一个窗口后
    WinLeave	            离开窗口前
    TabEnter	            进入另一个标签页面后
    TabLeave	            离开标签页面时
    TabNew	                创建新的标签页面时
    TabNewEntered	        进入新的标签页面后
    TabClosed	            关闭标签页面后
    CmdlineChanged	        命令行文本改动后
    CmdlineEnter	        进入命令行模式后
    CmdlineLeave	        退出命令行模式前
    CmdwinEnter	            进入命令行窗口后
    CmdwinLeave	            离开命令行窗口前
    InsertEnter	            进入插入模式
    InsertChange	        在插入 / 替换模式时输入 <Insert> 时
    InsertLeave	            离开插入模式时
    InsertCharPre	        在插入模式下输入每个字符前
    TextYankPost	        复制 / 删除文本后
    TextChanged	            正常模式下，文本更改时
    TextChangedI	        插入模式且没有弹出菜单的文本更改
    TextChangedP	        插入模式下且伴随弹出菜单的文本更改
    ColorSchemePre	        加载色彩方案前
    ColorScheme	            加载色彩方案后
    RemoteReply	            Vim 接收到服务器回复时
    QuickFixCmdPre	        执行 quickfix 命令前
    QuickFixCmdPost	        指定 quickfix 命令后
    SessionLoadPost	        加载会话文件后
    MenuPopup	            显示弹出菜单前
    CompleteChanged	        补全弹出菜单被更改，弹出菜单隐藏时不会触发该事件
    CompleteDone	        插入模式下，补全完成时
    User	                结合:doautocmd 进行使用
    Signal	                Neovim 接收到信号后
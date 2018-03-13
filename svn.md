1 命令模式坚决svn树冲突（local unversioned, incoming add upon update）
  (svn switch时本来没有的文件切换到一个有的分支时可能会产生)

  $ svn resolve --accept working removed_directory
  Resolved conflicted state of 'removed_directory'
  $ svn revert removed_directory
  Reverted 'removed_directory'
  $ svn status
  
  
 2 svn status显示当前svn状态包括冲突
 
 3 冲突解决示例
    C       TestController.php
    ?       TestController.php.mine
    ?       TestController.php.r11794
    ?       TestController.php.r15459
    svn resolve TestController.php
    
    Select: (p) postpone, (df) show diff, (e) edit file, (m) merge,
        (r) mark resolved, (mc) my side of conflict,
        (tc) their side of conflict, (s) show all options:
    选择tc 是更新最新的
    

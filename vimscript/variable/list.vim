let list = ['foo', 3, 'bar']
echo list
echo list[0]
echo list[-1]
echo list[0:1]
echo list[:1]
echo list[1:]
echo list + [1, 2]
echo "######### list function ########"
echo "### add"
call add(list, 1)
echo list
echo "### len"
call len(list)
echo len
echo "### get"
echo get(list, 0, "default")
echo get(list, 100, "default")
echo "### index"
" find: return index
echo index(list, 3)
" not find: return -1
echo index(list, 100)
echo "### join"
echo join(list)
echo join(list, "--")
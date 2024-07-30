let dict = {'a': 1, 100: 'foo', 'test': 'a'}
echo dict['a']
echo dict[100]
echo dict.100

echo "######### dict function ########"
echo "### remove or unlet"
let removed = remove(dict, 'a')
unlet dict.100
echo removed
echo dict
echo "### get"
echo get(dict, 'test', 'default')
echo get(dict, 'b', 'default')
echo "### has_key"
echo has_key(dict, 'test')
echo has_key(dict, 'b')
echo "### items"
echo items(dict)
echo "### keys"
echo keys(dict)
echo "### values"
echo values(dict)
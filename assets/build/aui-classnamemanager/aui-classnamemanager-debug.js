YUI.add('aui-classnamemanager', function (A, NAME) {

var ClassNameManager = A.ClassNameManager,
	_getClassName = ClassNameManager.getClassName,

	PREFIX = 'aui';

A.getClassName = A.cached(
	function() {
		var args = A.Array(arguments, 0, true);

		args.unshift(PREFIX);

		args[args.length] = true;

		return _getClassName.apply(ClassNameManager, args);
	}
);

}, '2.0.0pr5', {"requires": ["classnamemanager"]});

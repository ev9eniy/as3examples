package
base{
	import flash.utils.describeType;
	/**
	 * 
	 * Similar to PHP's print_r. You can pass in any object to trace all of its properties, and its properties properties, and so forth.
	 * 
	 * @example 

<code><pre>
object
(
	[url] => string[http://yahoo.com]
	[contentType] => object[null]
	[method] => string[GET]
	[data] => object[null]
	[digest] => object[null]
	[requestHeaders] => object
		(
			[length] => number[0]
		)
)
</pre></code>

	 * 
	 * @param	obj - pass in any type of object, accepts any variable type
	 * @param	omitProps - an array of properties to ignore in the traces. ex: ['stage', 'root', 'parent']
	 * @param	tabCount - this is mostly used internally to keep pushing out the tab count as it gets deeper. If you feel the need to push it out extra, go for it
	 * @param	runTrace - you can turn runTrace off if you only want to get the return string. either way it always returns the same string it is tracing
	 * @param	refArray - this is used internally to stop endless loops. If an object is in this array it is ignored.
	 * @return
	 */
	 
	public function trace_r(obj:*=null, omitProps:Array=null, tabCount:int=0, runTrace:Boolean=true, refArray:Array=null):String
	{
		//define vars
		var traceStr:String = '';
		var lineBreak:String = '\n';
		var tabStr:String = '';
		var item:String;
		var i:int;
		var k:int;
		var propsArray:Array = new Array();
		if (refArray == null) refArray = new Array(); 	// ensures that if there is a duplicate reference it doesn't continue to recursively call on that. preventing endless loops,
														// example, if a Sprite is on the stage, it will freeze up stuff like stage, parent, this, because it keeps on leading to the same references from different paths
		if (omitProps == null) omitProps = new Array();
		
		// --> setup vars
		
		//setup tab string for this depth
		for (i=0; i<tabCount; i++) tabStr += '\t';
		
		//begin traceStr
		traceStr += typeof(obj)+lineBreak;
		
		//var objNameStr:String = String(obj);
		//objNameStr = objNameStr.slice(8, objNameStr.length-1);
		
		//traceStr += objNameStr + lineBreak;
		traceStr += tabStr+'('+lineBreak;
		
		//grab dynamic properties first
		for (item in obj) if (omitProps.indexOf(item) < 0) propsArray.push(item);
		
		//now grab all non-dynamic accessible properties from the object using describeType(obj)
		var typeXML:XML = XML(describeType(obj));
		//trace(typeXML);
		var nodes:XMLList = typeXML.children();
		
		k = nodes.length();
		
		//yeah i should put it on more than 1 line, but its not THAT complicated
		for (i = 0; i < k; i++)
		{
			if (	
					XML(nodes[i]).localName() == 'accessor' &&
						(
						XML(nodes[i].@access == 'readonly') ||
						XML(nodes[i].@access == 'readwrite')
						)
					
					||
					
					XML(nodes[i]).localName() == 'variable'
				)
			{
				var propNameStr:String = String(XML(nodes[i].@name));
				if (omitProps.indexOf(propNameStr) < 0) propsArray.push(propNameStr);
			}
		}
		
		k = propsArray.length;
		for (i=0; i<k; i++) 
		{
			item = String(propsArray[i]);
			//var value;
			
			try
			{
				var value:* = obj[item];
				var itemTraceStr:String = tabStr + '\t[' + item + '] => ';
				
				if (value == null) itemTraceStr += typeof(value) + '[null]';
				else if (typeof(value) == 'object')
				{
					if (refArray.indexOf(value)  < 0)
					{
						refArray.push(value);
						itemTraceStr += trace_r(value, omitProps, tabCount+2, false, refArray);
					}
					else itemTraceStr += '>>> DUPLICATE REFERENCE, LOOK HIGHER FOR PROPERTIES';
				}
				else itemTraceStr += typeof(value) + '[' + value + ']';
				
				traceStr += itemTraceStr + lineBreak;
			}
			catch (e:Error)
			{
				//
			}
		}
		traceStr += tabStr+')';
		
		if (runTrace) trace_s(traceStr);
		
		return traceStr;
	}
}
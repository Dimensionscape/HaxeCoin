package;
import haxe.macro.Context;
import haxe.macro.Expr;
import protocol.EventCommandsEnum;
/**
 * ...
 * @author Christopher Speciale
 */
class CommandMacro
{

	public static function build():Array<Field>
	{
		var fields = Context.getBuildFields();
		var usedEnums:Array<String> = [];
		var commandEnums:Array<EventCommandsEnum> =  Type.allEnums(EventCommandsEnum);
		
		for (i in 0...commandEnums.length)
		{
			var value = commandEnums[i];
			fields.insert(0,
			{
				name:value.getName() + "________" + i,
				doc:null,
				pos:Context.currentPos(),
				access:[],
				kind:FieldType.FVar(null, null),
				meta:[]
			});
		}
		
		return fields;
	}

}
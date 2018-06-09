package t.cx.air.skin
{
	import flash.events.Event;

	public class CheckGroup
	{
		private var _bDefault : Boolean;
		private var box : Vector.<CheckBoxEx>;
		public function CheckGroup(bDefault : Boolean = true)
		{
			box = new Vector.<CheckBoxEx>();
			_bDefault = bDefault;
		}
		
		public function addBox(...params) : void
		{
			for(var i : uint = 0;i<params.length;i++)
			{
				var check : CheckBoxEx = params[i] as CheckBoxEx;
				if(check == null) return;
				check.addEventListener('SelectChanged',OnSelectedChanged);
				box.push(check);
			}
		}
		
		private function OnSelectedChanged(event : Event) : void
		{
			var check : CheckBoxEx = event.target as CheckBoxEx;
			if(!check.select && !_bDefault) return;
			for(var i : uint  =0;i<box.length;i++)
			{
				if(box[i] != check)
				{
					box[i].select = !check.select;
					if(!check.select) break;
				}
			}
			
		}
		public function Destroy() : void
		{
			for(var i : int = box.length-1;i>=0;i--)
			{
				var check : CheckBoxEx = box.pop();
				if(check)
				{
					check.removeEventListener('SelectChanged',OnSelectedChanged);
					check.Destroy();
					check = null;
				}
			}
			box = null;
		}
	}
}
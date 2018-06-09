package cx.client.logon.view.Plaza.yinhang
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.skin.CheckBoxEx;
	import t.cx.air.skin.CheckGroup;
	
	public class YinHangSprite extends Sprite
	{
		public function YinHangSprite()
		{
			super();
			this.visible  =false;
		}
		
		public function Show() : void
		{
			if(!this.visible)
			{
				theQq.select = true;
				theQq.RepeatSelect = false;
				theCq.RepeatSelect = false;
				theXiuGai.RepeatSelect = false;
				theQuQian.Show(Hide);
				theClose.addEventListener(MouseEvent.CLICK,onButtonEvent);
				theCq.addEventListener('SelectChanged',onSelected);
				theQq.addEventListener('SelectChanged',onSelected);
				theXiuGai.addEventListener('SelectChanged',onSelected);
				this.visible = true;
			}
		}
		public function Hide() : void
		{
			this.visible = false;
			theClose.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			for(var i : uint = 1;i < 4;i++)
			{
				this['check_' + i].removeEventListener('SelectChanged',onSelected);
				this['check_' + i].select = false;
				this['Sprite_' + i].Hide(true);
			}
		}
		private function onSelected(e : Event) : void
		{
			for(var i : uint = 1;i < 4;i++)
			{
				var check : CheckBoxEx = this['check_' + i];
				if(e.target != check)
				{
					check.select = false;
					this['Sprite_' + i].Hide(true);
				}else {
					this['Sprite_' + i].Show(Hide);
				}
			}
		}
		private function onButtonEvent( e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'CloseBtn':
				{
					Hide();
					break;
				}
			}
		}
		private function get theXiuGai() : CheckBoxEx
		{
			return this['check_3'];
		}
		private function get theQq() : CheckBoxEx
		{
			return this['check_1'];
		}
		private function get theCq() : CheckBoxEx
		{
			return this['check_2'];
		}
		
		private function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		
		private function get theChunQian() : ChunQian
		{
			return this['Sprite_2'];
		}
		private function get theQuQian() : QuQian
		{
			return this['Sprite_1'];
		}
		private function get theXiuGaiMima() : XiugaiMima
		{
			return this['Sprite_3'];
		}
	}
}
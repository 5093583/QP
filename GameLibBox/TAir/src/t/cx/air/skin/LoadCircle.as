package t.cx.air.skin
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Matrix;
    import flash.utils.Timer;

    public class LoadCircle extends Sprite
    {
        private var nums:int = 12;
        private var m2:Matrix = new Matrix();
        private var m:Matrix =  new Matrix();
        private var Abar:Array = new Array();
        private var segAngle:Number;
        private var seg:Number;
        private var j:Number = 0;
        private var timer:Timer =  new Timer(50);
        public function LoadCircle(w : Number,h : Number)
        {
            init(w,h);
        }
        private function init(w : Number,h : Number):void
        {
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0.4);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			this.mouseChildren = false;
			
			segAngle = 2 * Math.PI / this.nums;
            seg = 1 / this.nums;
            for (var i:int = 0; i < this.nums; i++)
            {
                var bar:Shape=new Shape();
                Abar[i] = bar;
                bar.graphics.beginFill(0xffffff);
                bar.graphics.drawRoundRect(0,0,10,3,4,4);
                bar.graphics.endFill();
                this.addChild(bar);
                m.identity();
                m.translate(7,-1);
                m.rotate(segAngle*i);
                m2.identity();
                m.concat(m2);
                bar.transform.matrix = m;
				bar.x +=w*0.5 - 1;
				bar.y += h*0.5 - 7;
            }
            timer.addEventListener(TimerEvent.TIMER,alphaHalder);
            timer.start();
        }
        private function alphaHalder(evt:TimerEvent):void
        {
            for (var i:int = 0; i < this.nums; i++)
            {
                var bar:Shape = Abar[i] as Shape;
                bar.alpha = j;
                if(j == 1.0833333333333333)
                {
                    j = 0;
                }
                j += seg;
            }
        }
		/**
		 * 销毁
		 * */
		public function destroy():void
		{
			timer.stop();
			timer.addEventListener(TimerEvent.TIMER,alphaHalder);
			timer = null;
			m = null;
			m2 = null;
			while(Abar.length>0)
			{
				var bar:* = Abar.shift();
				if(this.contains(bar))
				{
					this.removeChild(bar);
				}
				bar = null;
			}
		}
    }
}

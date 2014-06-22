import mx.transitions.Tween;
import mx.transitions.easing.*;
import mx.utils.Delegate;
import caurina.transitions.*;
import oxylus.vmig.bigImage;
import oxylus.vmig.rightScroller;
class oxylus.vmig.main extends MovieClip {
	private var node:XMLNode;
	public static var thC:MovieClip;
	
	public static var btC:MovieClip;
	public static var bigPict:Number;
	public static var smallThumb:Number;
	public static var buttonState:Number;
	public static var currentButton:Number = 1;
	public static var doneRght:Number;
	public static var ld:Number;
	public static var tr:Number =0;
	public var sus:Number = 20;
	public var drp:Number = 20;
	
	public static var resized:Number=1;
	public static var init:Number = 0;
	private var sw:Number;
	private var sh:Number;
	
	public function main(n) {
		_root["pr"]._x = Stage.width/2;
		_root["pr"]._y = Stage.height/2;
		tr = 0;
		smallThumb = 0;
		buttonState = 0;
		node = n;
		_root.attachMovie("BCK","bk",_root.getNextHighestDepth());
		_root["bk"]._width = Stage.width;
		_root["bk"]._height = Stage.height;
		_root["bk"]._alpha = 10;
		_root.createEmptyMovieClip("GAL",_root.getNextHighestDepth());
		/*_root["GAL"]._xscale = 0;
		_root["GAL"]._yscale = 0;*/
		
		_root["GAL"].attachMovie("PictHolder","IMAGE",_root["GAL"].getNextHighestDepth());
		_root["GAL"].attachMovie("Scroller","LEFT_SCROLLER",_root["GAL"].getNextHighestDepth());
		_root["GAL"].attachMovie("Scroller2","RIGHT_SCROLLER",_root["GAL"].getNextHighestDepth());
		
		//_root["GAL"]["IMAGE"].arrange();
		
		_root["GAL"]["LEFT_SCROLLER"].setNode(node);
		_root["GAL"]["IMAGE"].setNode(node.firstChild);
		
		_root["GAL"]["RIGHT_SCROLLER"].setNode(node.firstChild.firstChild.firstChild,node.firstChild.firstChild.lastChild.firstChild,node.firstChild.firstChild.attributes.ProductTitle);
		_root["GAL"]["RIGHT_SCROLLER"]._x = 243+640-_root["GAL"]["RIGHT_SCROLLER"]._width;
		
		bigImage.counter["txt"].text = "1 | 1/"+rightScroller.thumbCount;
		_root["GAL"]["LEFT_SCROLLER"]._x = 2;
		_root["GAL"]["LEFT_SCROLLER"]._y = 2;
		_root["GAL"]["IMAGE"]._x = 243;
		_root["GAL"]["IMAGE"]._y = _root["GAL"]["LEFT_SCROLLER"]._y+2;

		var myListener:Object = new Object();
		myListener.onResize = Delegate.create(this, cont);
		cont();
		Stage.addListener(myListener);

	}
	
	
	
	private function cont() {
		
		if (resized != 1) {
			resized = 1;
		}
		
		_root["bk"]._width = Stage.width+30;
		_root["bk"]._height = Stage.height+30;
		
		sw = Stage.width-251;
		sh = Stage.height-100;
		
		if (sw<640) {
			sw = 640;
		}
		if (sh<480) {
			sh = 480;
		}
		
				
		_root["GAL"]["IMAGE"].maxw = sw;
		_root["GAL"]["IMAGE"].maxh = sh;

		
	}
}
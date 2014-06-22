import flash.display.BitmapData;
import mx.transitions.Tween;
import oxylus.vmig.Utils;
import oxylus.vmig.main;
import oxylus.vmig.bigImage;
import oxylus.vmig.rightScroller;
class oxylus.vmig.Button_ extends MovieClip {
	private var Bg:MovieClip;
	private var Bgpict:MovieClip;
	private var Bgover:MovieClip;
	private var container:MovieClip;
	private var loader:MovieClip;
	private var over:MovieClip;
	private var mcLoader:MovieClipLoader;
	private var image:MovieClip;
	private var LabelUp:MovieClip;
	private var node:XMLNode;
	private var my_fmt:TextFormat;
	private var my_fmt2:TextFormat;
	private var _loaded:Boolean;
	public var nrBt:Number;
	private var txtBt:String;
	private var prod:String;
	private var prel:MovieClip;
	


	public function Button_() {
		prel = this["prel"];
		this["arrow"]._alpha = 50;
		this._loaded = false;
		my_fmt = new TextFormat();
		my_fmt.color = 0xA3A3A3;
		my_fmt2 = new TextFormat();
		my_fmt2.color = 0x636363;

		LabelUp = this["a"];
		LabelUp["txt"].selectable = false;
		LabelUp["txt2"].selectable = false;
		LabelUp["txt2"].wordWrap = true;
		LabelUp["txt"].setTextFormat(my_fmt);
		LabelUp["txt2"].setTextFormat(my_fmt2);
		LabelUp._x = 74;
		LabelUp._y = 2;
		
		container = this["b"]["b"]["a"];
		
		loader = this["d"];
		loader.setMask(this["mask2"]);
		
		Bg = this["c"];
		Bgpict = this["b"]["a"];
		Bgover = this["b"]["over"];
		over = this["over"];
		
		image = container.createEmptyMovieClip("myImage", container.getNextHighestDepth());
		mcLoader = new MovieClipLoader();
		mcLoader.addListener(this);

	}
	public function setData(n:String, myText:String, myText2:String, n2, aux4) {
		mcLoader.loadClip(n,image);
		LabelUp["txt"].text = myText;
		LabelUp["txt2"].text = myText2;

		node = n2;
		txtBt = aux4.lastChild.firstChild;
		prod = aux4.attributes.ProductTitle;
	}
	private function onLoadInit(image:MovieClip, container:MovieClip) {
		prel["prel"].stop();
		prel._alpha=0;
		var bd:BitmapData = new BitmapData(image._width, image._height);
		bd.draw(image);
		image.attachBitmap(bd,image.getNextHighestDepth(),"always",true);
		image._width = 56;
		image._height = 56;
	}
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number) {
		loader["txt"]["txt"]["txt"].text = Math.round(100/(bytesTotal/bytesLoaded))+"%";
		loader["txt"].gotoAndStop(Math.round(100/(bytesTotal/bytesLoaded)));
		loader["a"].gotoAndStop(Math.round(100/(bytesTotal/bytesLoaded)));
	}
	private function onLoadComplete() {
		
		Utils.mcPlay(this["b"]["b"],0,100);
		loader["a"]._visible = false;
		loader["txt"]._visible = false;
		this._loaded = true;
	}
	private function onRollOver() {
		if (this!=main.btC){
		this["arrow"]._alpha = 100;
		//main.btC = this;
		my_fmt.color = 0xE3E2E2;
		my_fmt2.color = 0x989898;
		formatText();
		var tw:Tween = new Tween(Bg, "_alpha", null, Bg._alpha, 0, 0.3, true);
		var tw3:Tween = new Tween(Bgpict, "_alpha", null, Bgpict._alpha, 0, 0.3, true);
		var tw4:Tween = new Tween(Bgover, "_alpha", null, Bgover._alpha, 100, 0.3, true);
		}

	}
	private function onRollOut() {
		if (this!=main.btC){
		this["arrow"]._alpha = 50;
		my_fmt.color = 0xA3A3A3;
		my_fmt2.color = 0x636363;
		formatText();
		var tw:Tween = new Tween(Bg, "_alpha", null, Bg._alpha, 100, 0.3, true);
		var tw3:Tween = new Tween(Bgpict, "_alpha", null, Bgpict._alpha, 100, 0.3, true);
		var tw4:Tween = new Tween(Bgover, "_alpha", null, Bgover._alpha, 0, 0.3, true);
		}

	}
	private function onPress() {
		main.btC.ch();
		_root["GAL"]["RIGHT_SCROLLER"].setNode(node,txtBt,prod);
		bigImage.counter["txt"].text = this.nrBt+" | 1/"+rightScroller.thumbCount;
		main.currentButton = this.nrBt;
		main.btC = this;

	}
	
	private function formatText() {
		LabelUp["txt"].setTextFormat(my_fmt);
		LabelUp["txt2"].setTextFormat(my_fmt2);
	}
	
	private function ch() {
		this["arrow"]._alpha = 50;
		my_fmt.color = 0xA3A3A3;
		my_fmt2.color = 0x636363;
		formatText();
		var tw:Tween = new Tween(main.btC["c"], "_alpha", null, main.btC["c"]._alpha, 100, 0.3, true);

		var tw3:Tween = new Tween(main.btC["b"]["a"], "_alpha", null, main.btC["b"]["a"]._alpha, 100, 0.3, true);
		var tw4:Tween = new Tween(main.btC["b"]["over"], "_alpha", null, main.btC["b"]["over"]._alpha, 0, 0.3, true);
	}

}
import flash.display.BitmapData;
import mx.transitions.Tween;
import oxylus.vmig.Utils;
import oxylus.vmig.main;
import oxylus.vmig.rightScroller;
import oxylus.vmig.bigImage;
class oxylus.vmig.thumb extends MovieClip {
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
	private var bigImageUrl:String;
	private var t1:Tween;
	private var t2:Tween;
	private var t3:Tween;
	private var t4:Tween;
	public var _ct:Number;
	public var nr:Number;
	private var prel:MovieClip;


	public function thumb() {
		prel = this["prel"];
		this._alpha = 50;
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
	public function setData(n:String, myText:String) {
		mcLoader.loadClip(n,image);
		bigImageUrl = myText;
	}
	private function onLoadInit(image:MovieClip, container:MovieClip) {
		prel["a"].stop();
		prel._alpha = 0;
		var bd:BitmapData = new BitmapData(image._width, image._height);
		bd.draw(image);
		image.attachBitmap(bd,image.getNextHighestDepth(),"always",true);
		image._width = 47;
		image._height = 36;
	}
	private function onLoadProgress(target:MovieClip, bytesLoaded:Number, bytesTotal:Number) {
		loader["txt"]["txt"]["txt"].text = Math.round(100/(bytesTotal/bytesLoaded))+"%";
		loader["txt"].gotoAndStop(Math.round(100/(bytesTotal/bytesLoaded)));
		loader["a"].gotoAndStop(Math.round(100/(bytesTotal/bytesLoaded)));
	}
	private function onLoadComplete() {

		main.doneRght++;
		Utils.mcPlay(this["b"]["b"],0,100);
		loader._visible = false;
	}
	private function onRollOver() {
		if (main.doneRght == rightScroller.thumbCount) {
			main.thC = this;

			this._alpha = 100;

			t1 = new Tween(this, "_x", null, this._x, -20, 0.2, true);
			t2 = new Tween(this, "_y", null, this._y, this._ct-6, 0.2, true);

			resize(65,49);

			var tw:Tween = new Tween(Bg, "_alpha", null, Bg._alpha, 0, 0.3, true);
			var tw2:Tween = new Tween(over, "_alpha", null, over._alpha, 100, 0.3, true);
			var tw3:Tween = new Tween(Bgpict, "_alpha", null, Bgpict._alpha, 0, 0.3, true);
			var tw4:Tween = new Tween(Bgover, "_alpha", null, Bgover._alpha, 100, 0.3, true);
		}
	}
	private function onRollOut() {
		if (main.doneRght == rightScroller.thumbCount) {
			this._alpha = 50;

			t3 = new Tween(this, "_x", null, this._x, -5, 0.2, true);
			t4 = new Tween(this, "_y", null, this._y, this._ct, 0.2, true);


			resize(51,40);
			var tw:Tween = new Tween(Bg, "_alpha", null, Bg._alpha, 100, 0.3, true);
			var over:Tween = new Tween(over, "_alpha", null, over._alpha, 0, 0.3, true);
			var tw3:Tween = new Tween(Bgpict, "_alpha", null, Bgpict._alpha, 100, 0.3, true);
			var tw4:Tween = new Tween(Bgover, "_alpha", null, Bgover._alpha, 0, 0.3, true);
		}
	}
	private function onPress() {
		if (main.doneRght == rightScroller.thumbCount) {
			ch();
			_root["GAL"]["IMAGE"].setData(bigImageUrl);
			bigImage.counter["txt"].text = main.currentButton+" | "+this.nr+"/"+rightScroller.thumbCount;
		}
	}
	private function resize(w:Number, h:Number) {
		var tw1:Tween = new Tween(this, "_width", null, this._width, w, 0.2, true);
		var tw2:Tween = new Tween(this, "_height", null, this._height, h, 0.2, true);

	}
	private function ch() {
		main.thC._alpha = 50;

		t3 = new Tween(main.thC, "_x", null, main.thC._x, -5, 0.2, true);
		t4 = new Tween(main.thC, "_y", null, main.thC._y, main.thC._ct, 0.2, true);


		resize(51,40);
		var tw:Tween = new Tween(main.thC["c"], "_alpha", null, main.thC["c"]._alpha, 100, 0.3, true);
		var over:Tween = new Tween(main.thC["over"], "_alpha", null, main.thC["over"]._alpha, 0, 0.3, true);
		var tw3:Tween = new Tween(main.thC["b"]["a"], "_alpha", null, main.thC["b"]["a"]._alpha, 100, 0.3, true);
		var tw4:Tween = new Tween(main.thC["b"]["over"], "_alpha", null, main.thC["b"]["over"]._alpha, 0, 0.3, true);

	}
	public function give() {
		return bigImageUrl;
	}
}
import mx.transitions.Tween;
import mx.transitions.easing.*;
import caurina.transitions.*;
import flash.filters.BlurFilter;
import oxylus.vmig.main;
import oxylus.vmig.bigImage;

class oxylus.vmig.rightScroller extends MovieClip {
	private var node:XMLNode;
	private var Mask:MovieClip;
	private var Bg:MovieClip;
	private var lst:MovieClip;
	private var tol:Number;
	private var descr:String;
	private var prodttl:String;
	public static var thumbCount:Number;

	public function rightScroller() {
		lst = this.createEmptyMovieClip("lst", this.getNextHighestDepth());
		Mask = this["mask"];

		lst.setMask(Mask);
		lst._x = 14;

	}
	public function Resize(myW, myH) {
		if (main.resized != 1) {
			Tweener.addTween(Mask,{_height:myH-44, time:.5, transition:"easeInOutQuad"});
		} else {
			Tweener.addTween(Mask,{_height:myH-44, time:0, transition:"easeInOutQuad"});

		}
		if ((lst._y<(myH-lst._height)) && (lst._height>myH)) {
			var tw4:Tween = new Tween(lst, "_y", null, lst._y, (myH-lst._height), 0.2, true);
		}
	}
	public function setNode(n:XMLNode, aux:String, aux2:String) {
		node = n;
		descr = aux;
		prodttl = aux2;
		buildList();

		_root["GAL"]["IMAGE"].setData(_root["GAL"]["RIGHT_SCROLLER"]["lst"]["sp"+0].give());


	}
	private function buildList() {
		var i:Number = 0;
		main.doneRght = 0;
		bigImage.LabelHtml["txt"].text = descr;
		bigImage.productTitle["txt"]["txt"].text = prodttl;
		bigImage.LabelHtml._y = 0;
		bigImage.ScrollBar_._y = bigImage.ScrollStick._height/2-bigImage.ScrollBar_._height/2;
		while (lst["sp"+i]) {
			lst["sp"+i].removeMovieClip();
			i++;
		}
		i = 0;
		for (; node != null; node=node.nextSibling) {
			lst.attachMovie("SmallPict","sp"+i,lst.getNextHighestDepth());
			lst["sp"+i]._y = (40+5)*i;
			lst["sp"+i]._ct = lst["sp"+i]._y;
			lst["sp"+i].setData(node.attributes.thumb,node.attributes.image);
			lst["sp"+i].nr = (i+1);
			lst["sp"+i]._x -= 5;

			i++;
			if (node.nextSibling.nextSibling == null) {
				break;
			}
		}
		tol = lst["sp"+0]._height;
		lst._y = 0;
		thumbCount = i;

	}
	public static function blur(blurY:Number, mc:MovieClip) {

		var blurX:Number = 0;
		var quality:Number = 3;
		var filter:BlurFilter = new BlurFilter(blurX, blurY, quality);
		mc.filters = [filter];
	}
	public function onMouseMove() {

		if ((_xmouse>0) && (_xmouse<Mask._width) && (_ymouse>0) && (_ymouse<Mask._height) && (Mask._height<lst._height)) {

			var ym:Number = _ymouse-tol;
			if (ym<0) {
				ym = 0;
			}
			if (ym>Mask._height-2*tol) {
				ym = Mask._height-2*tol+10;

			}
			var ypos:Number = Math.round((ym*(Mask._height-lst._height))/(Mask._height-2*tol));

			lst.onEnterFrame = function() {
				if (Math.abs(this._y-ypos)<1) {
					blur(0,this);
					delete this.onEnterFrame;
					this._y = ypos;

					return;
				} else {
					if (Math.abs(ypos-this._y)>20) {
						blur(Math.abs((ypos-this._y)/20),this);
					} else {
						blur(0,this);
					}
					this._y += (ypos-this._y)/3;
				}
			};

		}
	}
}
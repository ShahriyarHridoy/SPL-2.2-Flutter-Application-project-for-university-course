// Generated code from Butter Knife. Do not modify!
package io.github.visit_activities.travel.swipefragmentrealtime.modefragments;

import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.view.View;
import android.widget.ListView;
import butterknife.Unbinder;
import butterknife.internal.Utils;
import com.airbnb.lottie.LottieAnimationView;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;

public class HangoutSpotFragment_ViewBinding implements Unbinder {
  private HangoutSpotFragment target;

  @UiThread
  public HangoutSpotFragment_ViewBinding(HangoutSpotFragment target, View source) {
    this.target = target;

    target.listView = Utils.findRequiredViewAsType(source, R.id.listview, "field 'listView'", ListView.class);
    target.animationView = Utils.findRequiredViewAsType(source, R.id.animation_view, "field 'animationView'", LottieAnimationView.class);
  }

  @Override
  @CallSuper
  public void unbind() {
    HangoutSpotFragment target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.listView = null;
    target.animationView = null;
  }
}

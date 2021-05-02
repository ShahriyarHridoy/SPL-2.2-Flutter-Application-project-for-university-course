// Generated code from Butter Knife. Do not modify!
package io.github.visit_activities.destinations.description;

import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import butterknife.Unbinder;
import butterknife.internal.Utils;
import com.airbnb.lottie.LottieAnimationView;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;

public class CityHistoryActivity_ViewBinding implements Unbinder {
  private CityHistoryActivity target;

  @UiThread
  public CityHistoryActivity_ViewBinding(CityHistoryActivity target) {
    this(target, target.getWindow().getDecorView());
  }

  @UiThread
  public CityHistoryActivity_ViewBinding(CityHistoryActivity target, View source) {
    this.target = target;

    target.animationView = Utils.findRequiredViewAsType(source, R.id.animation_view, "field 'animationView'", LottieAnimationView.class);
    target.listView = Utils.findRequiredViewAsType(source, R.id.list, "field 'listView'", RecyclerView.class);
  }

  @Override
  @CallSuper
  public void unbind() {
    CityHistoryActivity target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.animationView = null;
    target.listView = null;
  }
}

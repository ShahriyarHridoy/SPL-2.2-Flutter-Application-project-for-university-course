// Generated code from Butter Knife. Do not modify!
package adapters;

import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import butterknife.Unbinder;
import butterknife.internal.Utils;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;

public class TimezoneAdapter$ViewHolder_ViewBinding implements Unbinder {
  private TimezoneAdapter.ViewHolder target;

  @UiThread
  public TimezoneAdapter$ViewHolder_ViewBinding(TimezoneAdapter.ViewHolder target, View source) {
    this.target = target;

    target.tvTimezoneLabel = Utils.findRequiredViewAsType(source, R.id.tvTimezoneLabel, "field 'tvTimezoneLabel'", TextView.class);
    target.ivTimezoneFlag = Utils.findRequiredViewAsType(source, R.id.ivTimezoneFlag, "field 'ivTimezoneFlag'", ImageView.class);
  }

  @Override
  @CallSuper
  public void unbind() {
    TimezoneAdapter.ViewHolder target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.tvTimezoneLabel = null;
    target.ivTimezoneFlag = null;
  }
}

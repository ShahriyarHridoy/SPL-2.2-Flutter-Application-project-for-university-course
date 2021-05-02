// Generated code from Butter Knife. Do not modify!
package io.github.visit_activities.utilities;

import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.view.View;
import android.widget.AutoCompleteTextView;
import android.widget.TextClock;
import butterknife.Unbinder;
import butterknife.internal.Utils;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;

public class WorldClockActivity_ViewBinding implements Unbinder {
  private WorldClockActivity target;

  @UiThread
  public WorldClockActivity_ViewBinding(WorldClockActivity target) {
    this(target, target.getWindow().getDecorView());
  }

  @UiThread
  public WorldClockActivity_ViewBinding(WorldClockActivity target, View source) {
    this.target = target;

    target.mAnalogClock = Utils.findRequiredViewAsType(source, R.id.clock_analog, "field 'mAnalogClock'", CustomAnalogClock.class);
    target.mTextClock = Utils.findRequiredViewAsType(source, R.id.clock_digital, "field 'mTextClock'", TextClock.class);
    target.mAutoCompleteTextViewTimezone = Utils.findRequiredViewAsType(source, R.id.actvTimezone, "field 'mAutoCompleteTextViewTimezone'", AutoCompleteTextView.class);
  }

  @Override
  @CallSuper
  public void unbind() {
    WorldClockActivity target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.mAnalogClock = null;
    target.mTextClock = null;
    target.mAutoCompleteTextViewTimezone = null;
  }
}

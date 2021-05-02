// Generated code from Butter Knife. Do not modify!
package io.github.visit_activities.utilities;

import android.annotation.SuppressLint;
import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.view.MotionEvent;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import butterknife.Unbinder;
import butterknife.internal.DebouncingOnClickListener;
import butterknife.internal.Utils;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;

public class ChecklistAdapter$ViewHolder_ViewBinding implements Unbinder {
  private ChecklistAdapter.ViewHolder target;

  private View view2131362245;

  private View view2131362247;

  private View view2131362250;

  private View view2131362246;

  @UiThread
  @SuppressLint("ClickableViewAccessibility")
  public ChecklistAdapter$ViewHolder_ViewBinding(final ChecklistAdapter.ViewHolder target,
      View source) {
    this.target = target;

    View view;
    view = Utils.findRequiredView(source, R.id.row_cb, "field 'mCheckBox' and method 'onClickCheckbox'");
    target.mCheckBox = Utils.castView(view, R.id.row_cb, "field 'mCheckBox'", CheckBox.class);
    view2131362245 = view;
    view.setOnClickListener(new DebouncingOnClickListener() {
      @Override
      public void doClick(View p0) {
        target.onClickCheckbox(p0);
      }
    });
    view = Utils.findRequiredView(source, R.id.row_handle, "field 'mHandle' and method 'onTouchHandle'");
    target.mHandle = Utils.castView(view, R.id.row_handle, "field 'mHandle'", ImageView.class);
    view2131362247 = view;
    view.setOnTouchListener(new View.OnTouchListener() {
      @Override
      public boolean onTouch(View p0, MotionEvent p1) {
        return target.onTouchHandle(p0, p1);
      }
    });
    target.mPlus = Utils.findRequiredViewAsType(source, R.id.row_plus, "field 'mPlus'", ImageView.class);
    view = Utils.findRequiredView(source, R.id.row_text, "field 'mText' and method 'onFocusChange'");
    target.mText = Utils.castView(view, R.id.row_text, "field 'mText'", EditText.class);
    view2131362250 = view;
    view.setOnFocusChangeListener(new View.OnFocusChangeListener() {
      @Override
      public void onFocusChange(View p0, boolean p1) {
        target.onFocusChange(p0, p1);
      }
    });
    view = Utils.findRequiredView(source, R.id.row_delete, "field 'mDelete' and method 'onClickDelete'");
    target.mDelete = Utils.castView(view, R.id.row_delete, "field 'mDelete'", ImageView.class);
    view2131362246 = view;
    view.setOnClickListener(new DebouncingOnClickListener() {
      @Override
      public void doClick(View p0) {
        target.onClickDelete(p0);
      }
    });
  }

  @Override
  @CallSuper
  public void unbind() {
    ChecklistAdapter.ViewHolder target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.mCheckBox = null;
    target.mHandle = null;
    target.mPlus = null;
    target.mText = null;
    target.mDelete = null;

    view2131362245.setOnClickListener(null);
    view2131362245 = null;
    view2131362247.setOnTouchListener(null);
    view2131362247 = null;
    view2131362250.setOnFocusChangeListener(null);
    view2131362250 = null;
    view2131362246.setOnClickListener(null);
    view2131362246 = null;
  }
}

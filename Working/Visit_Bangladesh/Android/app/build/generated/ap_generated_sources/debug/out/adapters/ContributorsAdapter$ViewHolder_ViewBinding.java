// Generated code from Butter Knife. Do not modify!
package adapters;

import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.support.v7.widget.AppCompatTextView;
import android.view.View;
import android.widget.TextView;
import butterknife.Unbinder;
import butterknife.internal.Utils;
import io.github.visit_activities.R;
import java.lang.IllegalStateException;
import java.lang.Override;
import utils.CircleImageView;

public class ContributorsAdapter$ViewHolder_ViewBinding implements Unbinder {
  private ContributorsAdapter.ViewHolder target;

  @UiThread
  public ContributorsAdapter$ViewHolder_ViewBinding(ContributorsAdapter.ViewHolder target,
      View source) {
    this.target = target;

    target.contributor_avatarImageView = Utils.findRequiredViewAsType(source, R.id.contributor_image, "field 'contributor_avatarImageView'", CircleImageView.class);
    target.contributor_unameTextView = Utils.findRequiredViewAsType(source, R.id.contributor_name, "field 'contributor_unameTextView'", TextView.class);
    target.contributor_contributionsTextView = Utils.findRequiredViewAsType(source, R.id.contributor_contributions, "field 'contributor_contributionsTextView'", AppCompatTextView.class);
  }

  @Override
  @CallSuper
  public void unbind() {
    ContributorsAdapter.ViewHolder target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");
    this.target = null;

    target.contributor_avatarImageView = null;
    target.contributor_unameTextView = null;
    target.contributor_contributionsTextView = null;
  }
}

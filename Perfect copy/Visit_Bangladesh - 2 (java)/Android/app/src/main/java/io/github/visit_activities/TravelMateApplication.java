package io.github.visit_activities;

import android.app.Application;

import com.blongho.country_data.World;

public class TravelMateApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        // Initialize the World library
        World.init(this);
    }
}

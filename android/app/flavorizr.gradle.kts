import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.example.newsapp.dev"
            resValue(type = "string", name = "app_name", value = "[DEV] News App")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.example.newsapp.staging"
            resValue(type = "string", name = "app_name", value = "[STG] News App")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.example.newsapp"
            resValue(type = "string", name = "app_name", value = "News App")
        }
    }
}
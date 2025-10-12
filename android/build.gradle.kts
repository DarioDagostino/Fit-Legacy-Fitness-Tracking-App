allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set a custom build directory for the root project
rootProject.buildDir = file("../../build")

subprojects {
    // Set a custom build directory for each subproject
    buildDir = rootProject.file("../../build/${project.name}")
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

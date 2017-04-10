job('imagebuild-dsl') {
    description('Build Application Image')
    environmentVariables {
        env('GIT_REPOSITORY_URI','')
        env('GIT_REPOSITORY_BRANCH','')
    }
}

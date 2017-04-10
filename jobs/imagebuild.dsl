job('imagebuild-dsl') {
    description('Build Application Image')
    parameters {
        stringParam('GIT_REPOSITORY_URI','')
        stringParam('GIT_REPOSITORY_BRANCH','')
    }
}

@objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
    if let error = error {
        print(error.localizedDescription)
        return
    }
        
    print("Image was saved in the photo gallery")
    UIApplication.shared.open(URL(string:"photos-redirect://")!)
}

func takeScreenshot(of collectionView: UIView) {
    // generate screenshot
    self.collectionView.screenshot { (screenshot) -> Void in
    // display screenshot
        self.screenshotView.image = screenshot // this apparently has no trouble accepting an optional : Hooray!
        self.screenshotView.contentMode = UIView.ContentMode.scaleAspectFit
        UIImageWriteToSavedPhotosAlbum(screenshot!, self, #selector(self.imageWasSaved), nil)
    }
}
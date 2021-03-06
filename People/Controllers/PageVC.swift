//
//  PageVC.swift
//  People
//
//  Created by Nishant Taneja on 06/01/21.
//

import UIKit

class PageVC: UIPageViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    /// Returns list of ViewControllers to use as swipable pages in PageViewController.
    private lazy var pages: [UIViewController]? = {
        if let peopleListVC = storyboard?.instantiateViewController(withIdentifier: PeopleListTVC.storyboardID),
           let enrollPersonVC = storyboard?.instantiateViewController(withIdentifier: EnrollPersonVC.storyboardID) {
            return [peopleListVC, enrollPersonVC]
        }
        return nil
    }()
    
    // IBActions
    @IBAction func segmentedControlValueDidChange(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if let pages = pages,
           (0..<pages.count).contains(selectedIndex),
           let currentVC = viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentVC) {
            setViewControllers([pages[selectedIndex]], direction: selectedIndex > currentIndex ? .forward : .reverse, animated: true, completion: nil)
        }
    }
}

//MARK:- Supporting Methods
extension PageVC {
    /// This method assigns a default ViewController to display when PageViewController is loaded.
    private func assignDefaultPage() {
        if let defaultVC = pages?.first {
            setViewControllers([defaultVC], direction: .forward, animated: true, completion: nil)
        }
    }
    /// This method assigns all required delegates and data sources.
    private func assignDelegatesAndDataSources() {
        delegate = self
        dataSource = self
    }
}

//MARK:- UIPageViewController Delegate
extension PageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished,
           completed,
           let currentVC = viewControllers?.first,
           let currentIndex = pages?.firstIndex(of: currentVC) {
            segmentedControl.selectedSegmentIndex = currentIndex
        }
    }
}

//MARK:- UIPageViewController DataSource
extension PageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pages = pages,
            let currentIndex = pages.firstIndex(of: viewController),
            currentIndex < pages.count - 1
        else { return nil }
        return pages[currentIndex + 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pages = pages,
              let currentIndex = pages.firstIndex(of: viewController),
              currentIndex > 0
        else { return nil }
        return pages[currentIndex - 1]
    }
}

//MARK:- Override View
extension PageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegatesAndDataSources()
        assignDefaultPage()
    }
}

var handleScroll = function (element) {
  var target_height = element ? $(element).offset().top - 150 : 0;
  $("body, html").animate({
            scrollTop: target_height}, 600);
};

ExtinctIn.Tour = tour = new Shepherd.Tour({defaults:
    {classes: 'shepherd-theme-arrows shepherd-open shepherd-element',
    scrollTo: true,
    scrollToHandler: handleScroll,
    showCancelLink: true}
  });

tour.addStep('Welcome',
  {title: 'Welcome to Plugged In',
  text: 'We are a professional networking site similar to LinkedIn. Would you like a tour?',
  buttons: [{text: "No", action: tour.cancel, classes: "shepherd-button-secondary"}, {text: "Yes!", action: tour.next}]
  }
);

tour.addStep('Tour Intro',
  {title: "Great!",
  text: "Let's begin. If at any point you'd like to exit, click the 'x' in the top right corner",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('Profile',
  {title: "Your Profile",
  text: "First, let's look at your profile",
  attachTo: ".user-card",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('Edit User Card',
  {title: "This is your user info",
  text: "Hover over the text and watch it turn grey. Go ahead and click to change something!",
  attachTo: ".user-card",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('Great job!',
  {title: "Great job!",
  text: "Make sure you clicked save to keep those changes!",
  attachTo: ".user-card",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('Job Experiences',
  {title: "Job Experiences",
  text: "Next are your job experiences. You can edit them the same way",
  attachTo: ".job-section",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('Job Experiences',
  {title: "Job Experiences",
  text: "Or add a new job!",
  attachTo: ".new-experience-form.job",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

tour.addStep('School Experiences',
  {title: "School Experiences",
  text: "You can edit and add schools, too!",
  attachTo: ".school-section",
  buttons: [{text: "Back", action: tour.back, classes: "shepherd-button-secondary"}, {text: "Next", action: tour.next}]
  }
);

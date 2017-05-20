describe("VoteForm", function() {
  var form, voteForm;

  beforeEach(function() {
    form = $([
      '<form id="new_vote" action="/amplifiers/reviews/42/votes" method="post">',
      '<input type="integer" name="vote[amplifier_id]" id="amplifier_id" />',
      '<textarea name="vote[user_id]" id="user_id"></textarea>'
    ].join('\n'));

    voteForm = newVoteForm(form);

    form.find("#amplifier_id").val(1);
    form.find("#user_id").val(1);
  });

  describe("new", function() {
    it("creates a new VoteForm object", function() {
      expect(voteForm).toBeDefined();
    });

    it("sets the element property", function() {
      expect(voteForm.element).toBeDefined();
    });
  });

  describe("userId", function() {
    it("retrieves the userId from the form", function() {
      expect(voteForm.userId()).toBe(1);
    });
  });


  describe("reviewId", function() {
    it("retrieves the reviewid from the form", function() {
      expect(voteForm.reviewId()).toBe("42");
    });
  });

  describe("attributes", function() {
    it("returns an object of vote attributes", function() {
      result = {
        user_id: 1,
        review_id: 1,
        video_id: "42"
      }
      expect(voteForm.attributes()).toEqual(result);
    });
  });
});

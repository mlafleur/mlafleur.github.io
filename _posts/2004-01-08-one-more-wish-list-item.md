---
ID: 470
post_title: One More Wish-List Item
author: Marc LaFleur
post_date: 2004-01-08 19:55:00
post_excerpt: ""
layout: post
permalink: >
  http://massivescale.com/one-more-wish-list-item/
published: true
views:
  - "261"
dsq_thread_id:
  - "3538634033"
---
<div class="Section1"> <p>As of today I need to add another item to my 2004 Technology Wish-List:</p> <p style='margin-left:.5in'><b><span style=';font-weight:bold'>To get the <i><span style='font-style: italic'>old</span></i> RichTextBox back</span></b></p> <p style='margin-left:.5in'><span style=''>Anyone who has to work with the RichTextBox for more than hour will start to wonder how this control ever made it though a review. Aside from the rather laughable fact that it doesn&rsquo;t inform the designer that the RTF property is bindable (only plain text is listed) there are a number of changes from the old ActiveX version that make it nearly impossible to use.</span></p> <p style='margin-left:.5in'><span style=''>For example, the following code will set the selected text to bold in the ActiveX version:</span></p> <p style='margin-left:1.0in'><span style=''>RICHTEXTBOX.SELBOLD = TRUE</span></p> <p style='margin-left:.5in'><span style=''>Nice and simple isn&rsquo;t it? Well, there is the C# equivalent:</span></p> <p style='margin-left:1.0in'><span style=''>RichTextBox.SelectionFont = new Font(RichTextBox.SelectionFont, FontStyle.Bold);</span></p> <p style='margin-left:.5in'><span style=''>Did they really need to make it so much more difficult?</span></p> <p style='margin-left:.5in'><span style=''>And too add even more pain, the old method would simply bold the text and leave any other formatting alone (i.e. underline, italic, font face, etc). Not so any more. That C# code above will blow away anything previously set.</span></p> <p style='margin-left:.5in'><span style=''>So if someone could please find the big red undo button over there, I would appreciate it.</span></p></div>
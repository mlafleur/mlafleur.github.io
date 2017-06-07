---
title: One More Wish-List Item
excerpt: ""
tags: null
---
<div class="Section1"> As of today I need to add another item to my 2004 Technology Wish-List:
 <b>To get the <i><span style='font-style: italic'>old</i> RichTextBox back</span></b>
 Anyone who has to work with the RichTextBox for more than hour will start to wonder how this control ever made it though a review. Aside from the rather laughable fact that it doesn&rsquo;t inform the designer that the RTF property is bindable (only plain text is listed) there are a number of changes from the old ActiveX version that make it nearly impossible to use.
 For example, the following code will set the selected text to bold in the ActiveX version:
 RICHTEXTBOX.SELBOLD = TRUE
 Nice and simple isn&rsquo;t it? Well, there is the C# equivalent:
 RichTextBox.SelectionFont = new Font(RichTextBox.SelectionFont, FontStyle.Bold);
 Did they really need to make it so much more difficult?
 And too add even more pain, the old method would simply bold the text and leave any other formatting alone (i.e. underline, italic, font face, etc). Not so any more. That C# code above will blow away anything previously set.
 So if someone could please find the big red undo button over there, I would appreciate it.
</div>
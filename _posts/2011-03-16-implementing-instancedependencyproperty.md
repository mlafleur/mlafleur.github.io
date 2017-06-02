---
Title: Implementing InstanceDependencyProperty
Excerpt: ""
Tags:
  - Skype
---
If you were looking to the UCMA 3.0 documentation for information on how to use <a href="http://msdn.microsoft.com/en-us/library/gg449634.aspx" target="_blank">InstanceDependencyProperty</a>, don't. Its incomplete and what is there is incorrect.

In an effort to implement my custom activities in the same way as Microsoft, I wanted to ensure that property values didn't get destroyed when you moved on to the next activity in your workflow. This is vital if you plan on returning values from a Workflow Activity for another Activity to make use of. For example, you likely want the Recognition Result from the question you asked them so you can act on it.

The InstanceDependencyProperty allows you to keep property changes you made within an Activity. Without it, the second the instance of that Activity is finished executing, the property changes are discarded. If you checked them from another activity, all you'd get are the default values. Not very useful if you ask me.

So here is an stripped down example of an Activity that implements InstanceDependencyProperties properly:

```csharp
using System.Workflow.ComponentModel;
using System.Workflow.ComponentModel.Serialization;
using Microsoft.Rtc.Workflow.Activities;

namespace AudioRecordingActivity
{
    public partial class Activity1 : Activity, IInstanceDependencyContainer
    {
        private static System.Collections.Generic.Dictionary _instanceDependencyProperties;

        public Activity1()
        {
            _instanceDependencyProperties = new System.Collections.Generic.Dictionary();
        }

        public System.Collections.Generic.Dictionary InstanceDependencyProperties
        {
            get { return _instanceDependencyProperties; }
        }

        public readonly static InstanceDependencyProperty MyStringProperty = InstanceDependencyProperty.Register("MyString", typeof(string), typeof(Activity1), "Empty");
        public string MyString
        {
            get
            {
                if (base.DesignMode) return InstanceDependencyHelper.GetValue(this, MyStringProperty).ToString();
                else return InstanceDependencyHelper.GetValue(this, this.WorkflowInstanceId, this.MyStringProperty).ToString();
            }

            set
            {
                if (base.DesignMode) InstanceDependencyHelper.SetValue(this, MyStringProperty, value);
                else return InstanceDependencyHelper.SetValue(this, this.WorkflowInstanceId, MyStringProperty, value);
            }
        }

        protected override ActivityExecutionStatus Execute(ActivityExecutionContext executionContext)
        {
            MyString = "Test String";
            return base.Execute(executionContext);
        }
    }
}
```

Here the key things to know:

1. Your Activity needs to implement the IInstanceDependencyContainer interface

2. ~~When you impement the interface, the private _instanceDependencyProperties dictionary _must be static_~~

3. Your properties must implement both prototypes of GetValue/SetValue. One is used for design-time, the other for run-time.

One other important note. In the documentation example they use a property with a TimeStamp type. You need to decorate this property with [TypeConverter(typeof(TimeSpanConverter))] or it will give you a very vague error at compile time.

> **UPDATE:** I had initially thought I had this fully working until I attempted to drop more than one of my custom activities on my workflow. I quickly found an issue with the static _instanceDependencyProperties however. Because it was static, changes to properties on Activity1 were reflected on Activity2. After some time with Reflector, looking at how Microsoft's activities were built, I noticed they used two different versions of InstanceDependencyHelper, one for design time and one for run time. Low and behold, if you implement both versions and remove the static statement you get the correct behavior. Its very unfortunate that the documentation doesn't explain this. 
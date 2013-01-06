/* ----------------------------------------------------------------------------

   Squeezer
   ========
   Flexible general-purpose compressor with a touch of lemon

   Copyright (c) 2013 Martin Zuther (http://www.mzuther.de/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   Thank you for using free software!

---------------------------------------------------------------------------- */

#ifndef __WRAPPED_PARAMETER_H__
#define __WRAPPED_PARAMETER_H__

#include "../JuceLibraryCode/JuceHeader.h"


//==============================================================================
/**
*/
class WrappedParameter
{
public:
    virtual ~WrappedParameter() {}

    virtual String getName() = 0;
    virtual void setName(const String& strParameterName) = 0;

    virtual float getDefaultValue() = 0;
    virtual void setDefaultValue(const String& strDefault, bool updateValue) = 0;

    virtual float getValue() = 0;
    virtual void setValue(float fValue) = 0;

    virtual float getRealValue() = 0;
    virtual void setRealValue(float fValue) = 0;

    virtual String getText() = 0;
    virtual void setText(const String& strText) = 0;

    virtual bool hasChanged() = 0;
    virtual void clearChangeFlag() = 0;

    virtual float getInterval() = 0;

    virtual float getValueFromText(const String& strText) = 0;
    virtual String getTextFromValue(float fValue) = 0;

    virtual void loadFromXml(XmlElement* xml) = 0;
    virtual void storeAsXml(XmlElement* xml) = 0;

protected:
    WrappedParameter() {}
};


#endif  // __WRAPPED_PARAMETER_H__


// Local Variables:
// ispell-local-dictionary: "british"
// End:

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.factories {
    import tInspector.com.codeazur.as3swf.tags.*;
    import tInspector.com.codeazur.as3swf.tags.etc.*;

    public class SWFTagFactory {

        public static function create(type:uint):ITag{
            switch (type){
                case TagEnd.TYPE:
                    return (new TagEnd());
                case TagShowFrame.TYPE:
                    return (new TagShowFrame());
                case TagDefineShape.TYPE:
                    return (new TagDefineShape());
                case TagPlaceObject.TYPE:
                    return (new TagPlaceObject());
                case TagRemoveObject.TYPE:
                    return (new TagRemoveObject());
                case TagDefineBits.TYPE:
                    return (new TagDefineBits());
                case TagDefineButton.TYPE:
                    return (new TagDefineButton());
                case TagJPEGTables.TYPE:
                    return (new TagJPEGTables());
                case TagSetBackgroundColor.TYPE:
                    return (new TagSetBackgroundColor());
                case TagDefineFont.TYPE:
                    return (new TagDefineFont());
                case TagDefineText.TYPE:
                    return (new TagDefineText());
                case TagDoAction.TYPE:
                    return (new TagDoAction());
                case TagDefineFontInfo.TYPE:
                    return (new TagDefineFontInfo());
                case TagDefineSound.TYPE:
                    return (new TagDefineSound());
                case TagStartSound.TYPE:
                    return (new TagStartSound());
                case TagDefineButtonSound.TYPE:
                    return (new TagDefineButtonSound());
                case TagSoundStreamHead.TYPE:
                    return (new TagSoundStreamHead());
                case TagSoundStreamBlock.TYPE:
                    return (new TagSoundStreamBlock());
                case TagDefineBitsLossless.TYPE:
                    return (new TagDefineBitsLossless());
                case TagDefineBitsJPEG2.TYPE:
                    return (new TagDefineBitsJPEG2());
                case TagDefineShape2.TYPE:
                    return (new TagDefineShape2());
                case TagDefineButtonCxform.TYPE:
                    return (new TagDefineButtonCxform());
                case TagProtect.TYPE:
                    return (new TagProtect());
                case TagPlaceObject2.TYPE:
                    return (new TagPlaceObject2());
                case TagRemoveObject2.TYPE:
                    return (new TagRemoveObject2());
                case TagDefineShape3.TYPE:
                    return (new TagDefineShape3());
                case TagDefineText2.TYPE:
                    return (new TagDefineText2());
                case TagDefineButton2.TYPE:
                    return (new TagDefineButton2());
                case TagDefineBitsJPEG3.TYPE:
                    return (new TagDefineBitsJPEG3());
                case TagDefineBitsLossless2.TYPE:
                    return (new TagDefineBitsLossless2());
                case TagDefineEditText.TYPE:
                    return (new TagDefineEditText());
                case TagDefineSprite.TYPE:
                    return (new TagDefineSprite());
                case TagProductInfo.TYPE:
                    return (new TagProductInfo());
                case TagFrameLabel.TYPE:
                    return (new TagFrameLabel());
                case TagSoundStreamHead2.TYPE:
                    return (new TagSoundStreamHead2());
                case TagDefineMorphShape.TYPE:
                    return (new TagDefineMorphShape());
                case TagDefineFont2.TYPE:
                    return (new TagDefineFont2());
                case TagExportAssets.TYPE:
                    return (new TagExportAssets());
                case TagImportAssets.TYPE:
                    return (new TagImportAssets());
                case TagEnableDebugger.TYPE:
                    return (new TagEnableDebugger());
                case TagDoInitAction.TYPE:
                    return (new TagDoInitAction());
                case TagDefineVideoStream.TYPE:
                    return (new TagDefineVideoStream());
                case TagVideoFrame.TYPE:
                    return (new TagVideoFrame());
                case TagDefineFontInfo2.TYPE:
                    return (new TagDefineFontInfo2());
                case TagDebugID.TYPE:
                    return (new TagDebugID());
                case TagEnableDebugger2.TYPE:
                    return (new TagEnableDebugger2());
                case TagScriptLimits.TYPE:
                    return (new TagScriptLimits());
                case TagSetTabIndex.TYPE:
                    return (new TagSetTabIndex());
                case TagFileAttributes.TYPE:
                    return (new TagFileAttributes());
                case TagPlaceObject3.TYPE:
                    return (new TagPlaceObject3());
                case TagImportAssets2.TYPE:
                    return (new TagImportAssets2());
                case TagDefineFontAlignZones.TYPE:
                    return (new TagDefineFontAlignZones());
                case TagCSMTextSettings.TYPE:
                    return (new TagCSMTextSettings());
                case TagDefineFont3.TYPE:
                    return (new TagDefineFont3());
                case TagSymbolClass.TYPE:
                    return (new TagSymbolClass());
                case TagMetadata.TYPE:
                    return (new TagMetadata());
                case TagDefineScalingGrid.TYPE:
                    return (new TagDefineScalingGrid());
                case TagDoABC.TYPE:
                    return (new TagDoABC());
                case TagDefineShape4.TYPE:
                    return (new TagDefineShape4());
                case TagDefineMorphShape2.TYPE:
                    return (new TagDefineMorphShape2());
                case TagDefineSceneAndFrameLabelData.TYPE:
                    return (new TagDefineSceneAndFrameLabelData());
                case TagDefineBinaryData.TYPE:
                    return (new TagDefineBinaryData());
                case TagDefineFontName.TYPE:
                    return (new TagDefineFontName());
                case TagStartSound2.TYPE:
                    return (new TagStartSound2());
                case TagDefineBitsJPEG4.TYPE:
                    return (new TagDefineBitsJPEG4());
                case TagDefineFont4.TYPE:
                    return (new TagDefineFont4());
                case TagSWFEncryptActions.TYPE:
                    return (new TagSWFEncryptActions());
                case TagSWFEncryptSignature.TYPE:
                    return (new TagSWFEncryptSignature());
                default:
                    return (new TagUnknown(type));
            };
        }

    }
}//package com.codeazur.as3swf.factories 

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -slp-vectorize-hor -slp-vectorize-hor-store -S < %s -mtriple=x86_64-apple-macosx -mcpu=haswell | FileCheck %s

;unsigned load_le32(unsigned char *data) {
;    unsigned le32 = (data[0]<<0) | (data[1]<<8) | (data[2]<<16) | (data[3]<<24);
;    return le32;
;}

define i32 @_Z9load_le32Ph(i8* nocapture readonly %data) {
; CHECK-LABEL: @_Z9load_le32Ph(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, i8* [[DATA:%.*]], align 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, i8* [[DATA]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, i8* [[ARRAYIDX1]], align 1
; CHECK-NEXT:    [[CONV2:%.*]] = zext i8 [[TMP1]] to i32
; CHECK-NEXT:    [[SHL3:%.*]] = shl nuw nsw i32 [[CONV2]], 8
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL3]], [[CONV]]
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds i8, i8* [[DATA]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load i8, i8* [[ARRAYIDX4]], align 1
; CHECK-NEXT:    [[CONV5:%.*]] = zext i8 [[TMP2]] to i32
; CHECK-NEXT:    [[SHL6:%.*]] = shl nuw nsw i32 [[CONV5]], 16
; CHECK-NEXT:    [[OR7:%.*]] = or i32 [[OR]], [[SHL6]]
; CHECK-NEXT:    [[ARRAYIDX8:%.*]] = getelementptr inbounds i8, i8* [[DATA]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load i8, i8* [[ARRAYIDX8]], align 1
; CHECK-NEXT:    [[CONV9:%.*]] = zext i8 [[TMP3]] to i32
; CHECK-NEXT:    [[SHL10:%.*]] = shl nuw i32 [[CONV9]], 24
; CHECK-NEXT:    [[OR11:%.*]] = or i32 [[OR7]], [[SHL10]]
; CHECK-NEXT:    ret i32 [[OR11]]
;
entry:
  %0 = load i8, i8* %data, align 1
  %conv = zext i8 %0 to i32
  %arrayidx1 = getelementptr inbounds i8, i8* %data, i64 1
  %1 = load i8, i8* %arrayidx1, align 1
  %conv2 = zext i8 %1 to i32
  %shl3 = shl nuw nsw i32 %conv2, 8
  %or = or i32 %shl3, %conv
  %arrayidx4 = getelementptr inbounds i8, i8* %data, i64 2
  %2 = load i8, i8* %arrayidx4, align 1
  %conv5 = zext i8 %2 to i32
  %shl6 = shl nuw nsw i32 %conv5, 16
  %or7 = or i32 %or, %shl6
  %arrayidx8 = getelementptr inbounds i8, i8* %data, i64 3
  %3 = load i8, i8* %arrayidx8, align 1
  %conv9 = zext i8 %3 to i32
  %shl10 = shl nuw i32 %conv9, 24
  %or11 = or i32 %or7, %shl10
  ret i32 %or11
}

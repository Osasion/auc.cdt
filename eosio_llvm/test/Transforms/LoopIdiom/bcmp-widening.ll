; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-idiom < %s -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

; We do not necessarily have a loop with comparison of two loaded values.
; The loop may already be doing bcmp() itself. We just need to widen it.

; FIXME: -memcpyopt does not promote memcmp() source into memcmp() / bcmp().

; #include <algorithm>
;
; // FIXME
; bool widening_of_bcmp(char const* ptr0, char const* ptr1, size_t count) {
;   static constexpr auto Size = 32, Step = 32;
;   for(size_t i = 0; i < count; i++, ptr0 += Step, ptr1 += Step) {
;     if(bcmp(ptr0, ptr1, Size) != 0)
;       return false;
;   }
;   return true;
; }
;
; // FIXME
; bool widening_of_overlapping_bcmp(char const* ptr0, char const* ptr1, size_t count) {
;   static constexpr auto Size = 32, Step = 16;
;   for(size_t i = 0; i < count; i++, ptr0 += Step, ptr1 += Step) {
;     if(bcmp(ptr0, ptr1, Size) != 0)
;       return false;
;   }
;   return true;
; }

declare i32 @bcmp(i8*, i8*, i64)

; FIXME
define i1 @_Z18widening_of_bcmpPKcS0_m(i8* %ptr0, i8* %ptr1, i64 %count) {
; CHECK-LABEL: @_Z18widening_of_bcmpPKcS0_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP7:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP7]], label [[CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_010:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_INC:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PTR1_ADDR_09:%.*]] = phi i8* [ [[ADD_PTR2:%.*]], [[FOR_INC]] ], [ [[PTR1:%.*]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PTR0_ADDR_08:%.*]] = phi i8* [ [[ADD_PTR:%.*]], [[FOR_INC]] ], [ [[PTR0:%.*]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BCMP:%.*]] = tail call i32 @bcmp(i8* [[PTR0_ADDR_08]], i8* [[PTR1_ADDR_09]], i64 32)
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[BCMP]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_INC]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw i64 [[I_010]], 1
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds i8, i8* [[PTR0_ADDR_08]], i64 32
; CHECK-NEXT:    [[ADD_PTR2]] = getelementptr inbounds i8, i8* [[PTR1_ADDR_09]], i64 32
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[CLEANUP_LOOPEXIT]]
; CHECK:       cleanup.loopexit:
; CHECK-NEXT:    [[RES_PH:%.*]] = phi i1 [ false, [[FOR_BODY]] ], [ true, [[FOR_INC]] ]
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    [[RES:%.*]] = phi i1 [ true, [[ENTRY:%.*]] ], [ [[RES_PH]], [[CLEANUP_LOOPEXIT]] ]
; CHECK-NEXT:    ret i1 [[RES]]
;
entry:
  %cmp7 = icmp eq i64 %count, 0
  br i1 %cmp7, label %cleanup, label %for.body

for.body:                                         ; preds = %entry, %for.inc
  %i.010 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %ptr1.addr.09 = phi i8* [ %add.ptr2, %for.inc ], [ %ptr1, %entry ]
  %ptr0.addr.08 = phi i8* [ %add.ptr, %for.inc ], [ %ptr0, %entry ]
  %bcmp = tail call i32 @bcmp(i8* %ptr0.addr.08, i8* %ptr1.addr.09, i64 32)
  %cmp1 = icmp eq i32 %bcmp, 0
  br i1 %cmp1, label %for.inc, label %cleanup

for.inc:                                          ; preds = %for.body
  %inc = add nuw i64 %i.010, 1
  %add.ptr = getelementptr inbounds i8, i8* %ptr0.addr.08, i64 32
  %add.ptr2 = getelementptr inbounds i8, i8* %ptr1.addr.09, i64 32
  %cmp = icmp ult i64 %inc, %count
  br i1 %cmp, label %for.body, label %cleanup

cleanup:                                          ; preds = %for.body, %for.inc, %entry
  %res = phi i1 [ true, %entry ], [ true, %for.inc ], [ false, %for.body ]
  ret i1 %res
}

; FIXME
define i1 @_Z30widening_of_overlapping_bcmpPKcS0_m(i8* %ptr0, i8* %ptr1, i64 %count) {
; CHECK-LABEL: @_Z30widening_of_overlapping_bcmpPKcS0_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP7:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP7]], label [[CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_010:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_INC:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PTR1_ADDR_09:%.*]] = phi i8* [ [[ADD_PTR2:%.*]], [[FOR_INC]] ], [ [[PTR1:%.*]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[PTR0_ADDR_08:%.*]] = phi i8* [ [[ADD_PTR:%.*]], [[FOR_INC]] ], [ [[PTR0:%.*]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BCMP:%.*]] = tail call i32 @bcmp(i8* [[PTR0_ADDR_08]], i8* [[PTR1_ADDR_09]], i64 32)
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[BCMP]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_INC]], label [[CLEANUP_LOOPEXIT:%.*]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[INC]] = add nuw i64 [[I_010]], 1
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds i8, i8* [[PTR0_ADDR_08]], i64 16
; CHECK-NEXT:    [[ADD_PTR2]] = getelementptr inbounds i8, i8* [[PTR1_ADDR_09]], i64 16
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[CLEANUP_LOOPEXIT]]
; CHECK:       cleanup.loopexit:
; CHECK-NEXT:    [[RES_PH:%.*]] = phi i1 [ false, [[FOR_BODY]] ], [ true, [[FOR_INC]] ]
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    [[RES:%.*]] = phi i1 [ true, [[ENTRY:%.*]] ], [ [[RES_PH]], [[CLEANUP_LOOPEXIT]] ]
; CHECK-NEXT:    ret i1 [[RES]]
;
entry:
  %cmp7 = icmp eq i64 %count, 0
  br i1 %cmp7, label %cleanup, label %for.body

for.body:                                         ; preds = %entry, %for.inc
  %i.010 = phi i64 [ %inc, %for.inc ], [ 0, %entry ]
  %ptr1.addr.09 = phi i8* [ %add.ptr2, %for.inc ], [ %ptr1, %entry ]
  %ptr0.addr.08 = phi i8* [ %add.ptr, %for.inc ], [ %ptr0, %entry ]
  %bcmp = tail call i32 @bcmp(i8* %ptr0.addr.08, i8* %ptr1.addr.09, i64 32)
  %cmp1 = icmp eq i32 %bcmp, 0
  br i1 %cmp1, label %for.inc, label %cleanup

for.inc:                                          ; preds = %for.body
  %inc = add nuw i64 %i.010, 1
  %add.ptr = getelementptr inbounds i8, i8* %ptr0.addr.08, i64 16
  %add.ptr2 = getelementptr inbounds i8, i8* %ptr1.addr.09, i64 16
  %cmp = icmp ult i64 %inc, %count
  br i1 %cmp, label %for.body, label %cleanup

cleanup:                                          ; preds = %for.body, %for.inc, %entry
  %res = phi i1 [ true, %entry ], [ true, %for.inc ], [ false, %for.body ]
  ret i1 %res
}

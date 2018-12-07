/*
 * Copyright (c) 2012 ZES Inc. All rights reserved. This software is the
 * confidential and proprietary information of ZES Inc. You shall not disclose
 * such Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with ZES Inc.
 * (http://www.zesinc.co.kr/)
 */
package zes.base.vo;

import java.util.List;

/**
 * Base 트리(Tree) 구조 General VO
 * <p />
 * Chain 지원
 * 
 * @version 1.0
 * @since openworks-1.0 프로젝트. (After JDK 1.6)
 * @author (주)제스아이엔씨 기술연구소
 * 
 *         <pre>
 * << 개정이력(Modification Information) >>
 *    
 *     수정일       수정자   수정내용
 * --------------  --------  -------------------------------
 *  2012. 3. 4.    방기배   JDK 1.6 이상 버전에 최적화 수정 및 주석 보강
 * </pre>
 * @see
 */
public class TreeVO extends BaseVO {

    private static final long serialVersionUID = 3840904599055409688L;

    /** 자식 노드 */
    private List<TreeVO> children;
    /** 노드 ID */
    private String id;
    /** 노드 텍스트 */
    private String text;
    /** 노드 링크 */
    private String href;
    /** Leaf 노드 여부 */
    private Boolean leaf;
    /** 사용여부 */
    private String cls;
    /** 메뉴끌기 여부 */
    private Boolean draggable;
    /** 아이콘 클레스 */
    private String iconCls;
    /** 트리메뉴 깊이 */
    private Integer depth;
    
    private Boolean checked;

    /**
     * List children을 반환
     * 
     * @return List children
     */
    public List<TreeVO> getChildren() {
        return children;
    }

    /**
     * children을 설정
     * 
     * @param children 을(를) List children로 설정
     */
    public TreeVO setChildren(List<TreeVO> children) {
        this.children = children;
        return this;
    }

    /**
     * String id을 반환
     * 
     * @return String id
     */
    public String getId() {
        return id;
    }

    /**
     * id을 설정
     * 
     * @param id 을(를) String id로 설정
     */
    public TreeVO setId(String id) {
        this.id = id;
        return this;
    }

    /**
     * String text을 반환
     * 
     * @return String text
     */
    public String getText() {
        return text;
    }

    /**
     * text을 설정
     * 
     * @param text 을(를) String text로 설정
     */
    public TreeVO setText(String text) {
        this.text = text;
        return this;
    }

    /**
     * String href을 반환
     * 
     * @return String href
     */
    public String getHref() {
        return href;
    }

    /**
     * href을 설정
     * 
     * @param href 을(를) String href로 설정
     */
    public TreeVO setHref(String href) {
        this.href = href;
        return this;
    }

    /**
     * Boolean leaf을 반환
     * 
     * @return Boolean leaf
     */
    public Boolean getLeaf() {
        return leaf;
    }

    /**
     * leaf을 설정
     * 
     * @param leaf 을(를) Boolean leaf로 설정
     */
    public TreeVO setLeaf(Boolean leaf) {
        this.leaf = leaf;
        return this;
    }

    /**
     * String cls을 반환
     * 
     * @return String cls
     */
    public String getCls() {
        return cls;
    }

    /**
     * cls을 설정
     * 
     * @param cls 을(를) String cls로 설정
     */
    public void setCls(String cls) {
        this.cls = cls;
    }

    /**
     * Boolean draggable을 반환
     * 
     * @return Boolean draggable
     */
    public Boolean getDraggable() {
        return draggable;
    }

    /**
     * draggable을 설정
     * 
     * @param draggable 을(를) Boolean draggable로 설정
     */
    public void setDraggable(Boolean draggable) {
        this.draggable = draggable;
    }

    /**
     * String iconCls을 반환
     * 
     * @return String iconCls
     */
    public String getIconCls() {
        return iconCls;
    }

    /**
     * iconCls을 설정
     * 
     * @param iconCls 을(를) String iconCls로 설정
     */
    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    /**
     * Integer depth을 반환
     * 
     * @return Integer depth
     */
    public Integer getDepth() {
        return depth;
    }

    /**
     * depth을 설정
     * 
     * @param depth 을(를) Integer depth로 설정
     */
    public void setDepth(Integer depth) {
        this.depth = depth;
    }

    /**
     * Boolean leaf을 반환
     * 
     * @return Boolean leaf
     */
    public Boolean getChecked() {
        return checked;
    }

    /**
     * leaf을 설정
     * 
     * @param leaf 을(를) Boolean leaf로 설정
     */
    public TreeVO setChecked(Boolean checked) {
        this.checked = checked;
        return this;
    }
}
